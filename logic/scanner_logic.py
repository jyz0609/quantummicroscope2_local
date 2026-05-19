from __future__ import annotations

import logging
import traceback

import numpy as np
from qtpy import QtCore

from hardware.dummy_hardware import DummyMicroscopeHardware
from logic.models import AnalysisParameters, G2Parameters, HardwareConfig, ScanParameters


LOGGER = logging.getLogger(__name__)


class _ScanWorker(QtCore.QObject):
    sigLog = QtCore.Signal(str)
    sigError = QtCore.Signal(str)
    sigImageReady = QtCore.Signal(object)
    sigCountsReady = QtCore.Signal(object)
    sigFinished = QtCore.Signal(str)

    def __init__(self, hardware: DummyMicroscopeHardware, params: ScanParameters):
        super().__init__()
        self._hardware = hardware
        self._params = params
        self._cancel_requested = False

    @QtCore.Slot()
    def run(self):
        try:
            image = self._hardware.run_scan(
                self._params,
                image_callback=self.sigImageReady.emit,
                cancel_requested=lambda: self._cancel_requested,
            )
            self.sigImageReady.emit(image)
            self.sigCountsReady.emit(self._hardware.read_counts())
            if self._cancel_requested:
                self.sigFinished.emit("Scan cancelled")
            else:
                self.sigFinished.emit("Scan finished")
        except Exception as exc:
            LOGGER.exception("Scan worker failed")
            self.sigError.emit(f"{exc}\n{traceback.format_exc(limit=4)}")

    @QtCore.Slot()
    def cancel(self):
        self._cancel_requested = True


class ScannerLogic(QtCore.QObject):
    sigStatusChanged = QtCore.Signal(str)
    sigLog = QtCore.Signal(str)
    sigError = QtCore.Signal(str)
    sigScanStarted = QtCore.Signal()
    sigScanFinished = QtCore.Signal(str)
    sigImageReady = QtCore.Signal(object)
    sigCountsReady = QtCore.Signal(object)
    sigSuggestedFilename = QtCore.Signal(str)

    def __init__(self, config: HardwareConfig | None = None, parent=None):
        super().__init__(parent)
        self.config = config or HardwareConfig.load()
        self.scan_params = ScanParameters.defaults(self.config)
        self.analysis_params = AnalysisParameters()
        self.g2_params = G2Parameters()
        self._hardware = DummyMicroscopeHardware(progress=self.sigLog.emit)
        self._thread: QtCore.QThread | None = None
        self._worker: _ScanWorker | None = None

    @QtCore.Slot(object)
    def update_scan_parameters(self, params: ScanParameters):
        self.scan_params = params

    @QtCore.Slot(object)
    def update_analysis_parameters(self, params: AnalysisParameters):
        self.analysis_params = params

    @QtCore.Slot(object)
    def update_g2_parameters(self, params: G2Parameters):
        self.g2_params = params

    @QtCore.Slot()
    def suggest_filename(self) -> str:
        filename = self.scan_params.suggested_filename()
        self.scan_params.data_file = filename
        self.sigSuggestedFilename.emit(filename)
        self.sigLog.emit(f"Suggested filename: {filename}")
        return filename

    @QtCore.Slot()
    def start_scan(self):
        if self._thread is not None:
            self.sigLog.emit("Scan is already running")
            return

        if not self.scan_params.data_file:
            self.suggest_filename()

        self.sigStatusChanged.emit("Running")
        self.sigScanStarted.emit()
        self.sigLog.emit(
            f"Starting {self.scan_params.speed_mode} scan in "
            f"{'offline' if self.scan_params.offline_mode else 'hardware'} mode"
        )

        self._thread = QtCore.QThread(self)
        self._worker = _ScanWorker(self._hardware, self.scan_params)
        self._worker.moveToThread(self._thread)
        self._thread.started.connect(self._worker.run)
        self._worker.sigLog.connect(self.sigLog)
        self._worker.sigError.connect(self._handle_worker_error)
        self._worker.sigImageReady.connect(self.sigImageReady)
        self._worker.sigCountsReady.connect(self.sigCountsReady)
        self._worker.sigFinished.connect(self._handle_worker_finished)
        self._worker.sigFinished.connect(self._thread.quit)
        self._worker.sigError.connect(self._thread.quit)
        self._thread.finished.connect(self._worker.deleteLater)
        self._thread.finished.connect(self._cleanup_thread)
        self._thread.start()

    @QtCore.Slot()
    def cancel_scan(self):
        if self._worker is None:
            self.sigLog.emit("No active scan to cancel")
            return
        self.sigLog.emit("Cancel requested")
        QtCore.QMetaObject.invokeMethod(self._worker, "cancel", QtCore.Qt.QueuedConnection)

    @QtCore.Slot(int, int)
    def move_to_pixel(self, x: int, y: int):
        try:
            x_voltage, y_voltage = self._hardware.move_to_pixel(x, y, self.scan_params)
            self.sigLog.emit(f"Moved to pixel ({x}, {y}) at ({x_voltage:.4f} V, {y_voltage:.4f} V)")
        except Exception as exc:
            self.sigError.emit(str(exc))

    @QtCore.Slot()
    def count_signals(self):
        try:
            counts = self._hardware.read_counts()
            self.sigCountsReady.emit(counts)
            self.sigLog.emit("Updated signal counts")
        except Exception as exc:
            self.sigError.emit(str(exc))

    @QtCore.Slot()
    def analyze_current_file(self):
        # Full ETA migration is intentionally left behind the logic boundary.
        # The first increment keeps the UI responsive and makes the integration point explicit.
        dim = max(4, int(self.scan_params.dim_y))
        axis = np.linspace(-1.0, 1.0, dim)
        xx, yy = np.meshgrid(axis, axis)
        image = np.exp(-((xx + 0.25) ** 2 + (yy - 0.15) ** 2) * 10.0)
        self.sigImageReady.emit(image)
        self.sigLog.emit(f"Analysis placeholder displayed for {self.analysis_params.data_file}")

    @QtCore.Slot(str)
    def _handle_worker_finished(self, message: str):
        self.sigStatusChanged.emit("Idle")
        self.sigScanFinished.emit(message)
        self.sigLog.emit(message)

    @QtCore.Slot(str)
    def _handle_worker_error(self, message: str):
        self.sigStatusChanged.emit("Error")
        self.sigError.emit(message)

    @QtCore.Slot()
    def _cleanup_thread(self):
        self._thread = None
        self._worker = None
