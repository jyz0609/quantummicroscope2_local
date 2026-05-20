from __future__ import annotations

import logging
import re

import numpy as np
from qtpy import QtCore

from quantummicroscope.analysis import g2_coordinates
from quantummicroscope.core.connector import Connector
from quantummicroscope.core.module import BaseModule
from quantummicroscope.hardware.scanner.dummy_scanner_hardware import DummyScannerHardware
from quantummicroscope.logic.models import AnalysisParameters, G2Parameters, HardwareConfig, ScanParameters
from quantummicroscope.logic.workers import ScanWorker


LOGGER = logging.getLogger(__name__)


class ScannerLogic(BaseModule):
    scanner = Connector(interface="ScannerInterface")
    counter = Connector(interface="CounterInterface")

    sigStatusChanged = QtCore.Signal(str)
    sigLog = QtCore.Signal(str)
    sigError = QtCore.Signal(str)
    sigScanStarted = QtCore.Signal()
    sigScanFinished = QtCore.Signal(str)
    sigImageUpdated = QtCore.Signal(object)
    sigCountsUpdated = QtCore.Signal(object)
    sigImageReady = QtCore.Signal(object)
    sigCountsReady = QtCore.Signal(object)
    sigSuggestedFilename = QtCore.Signal(str)
    sigCopyText = QtCore.Signal(str)

    def __init__(self, config: HardwareConfig | None = None, parent=None):
        super().__init__(parent=parent)
        self.config = config or HardwareConfig.load()
        self.scan_params = ScanParameters.defaults(self.config)
        self.analysis_params = AnalysisParameters()
        self.g2_params = G2Parameters()
        self._offline_scanner = DummyScannerHardware(progress=self.sigLog.emit)
        type(self).scanner.connect(self, self._offline_scanner)
        type(self).counter.connect(self, self._offline_scanner)
        self._thread: QtCore.QThread | None = None
        self._worker: ScanWorker | None = None
        self.current_x_pixel = 1
        self.current_y_pixel = 1
        self.center_locked = False

    def connect_modules(self, *, scanner=None, counter=None) -> None:
        if scanner is not None:
            type(self).scanner.connect(self, scanner)
        if counter is not None:
            type(self).counter.connect(self, counter)

    @QtCore.Slot(object)
    def update_scan_parameters(self, params: ScanParameters):
        self.scan_params = params

    @QtCore.Slot(object)
    def update_analysis_parameters(self, params: AnalysisParameters):
        self.analysis_params = params

    @QtCore.Slot(object)
    def update_g2_parameters(self, params: G2Parameters):
        self.g2_params = params

    @QtCore.Slot(int, int)
    def update_current_position(self, x: int, y: int):
        self.current_x_pixel = x
        self.current_y_pixel = y

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
        self.scanner().configure_scan(self.scan_params)
        self._worker = ScanWorker(self.scanner(), self.counter(), self.scan_params)
        self._worker.moveToThread(self._thread)
        self._thread.started.connect(self._worker.run)
        self._worker.sigLog.connect(self.sigLog)
        self._worker.sigError.connect(self._handle_worker_error)
        self._worker.sigImageUpdated.connect(self._emit_image)
        self._worker.sigCountsUpdated.connect(self._emit_counts)
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
            self.update_current_position(x, y)
            x_voltage, y_voltage = self.scanner().move_to_pixel(x, y, self.scan_params)
            self.sigLog.emit(f"Moved to pixel ({x}, {y}) at ({x_voltage:.4f} V, {y_voltage:.4f} V)")
        except Exception as exc:
            self.sigError.emit(str(exc))

    @QtCore.Slot()
    def count_signals(self):
        try:
            counts = self.counter().read_counts()
            self._emit_counts(counts)
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
        self._emit_image(image)
        self.sigLog.emit(f"Analysis placeholder displayed for {self.analysis_params.data_file}")

    @QtCore.Slot(float)
    def set_scope_length(self, value: float):
        self.scan_params.scope_length = value
        if self.scan_params.lens_slope:
            amp = round(value / self.scan_params.lens_slope, 5)
            self.scan_params.amp_x = amp
            self.scan_params.amp_y = amp
        self.sigLog.emit(f"Scope length set to {value:g} um")

    @QtCore.Slot(float)
    def set_step_size_nm(self, value: float):
        self.scan_params.step_size_nm = value
        if value > 0:
            self.scan_params.dim_y = max(4, round(self.scan_params.scope_length * 1000 / value))
        self.sigLog.emit(f"Step size set to {value:g} nm")

    @QtCore.Slot()
    def copy_position_info(self):
        data_file = self.analysis_params.data_file or self.scan_params.data_file
        name_match = re.search(r"/([^/]+)_date", data_file.replace("\\", "/"))
        time_match = re.search(r"time\(([^)]+)\)", data_file)
        date_match = re.search(r"date\(([^)]+)\)", data_file)
        if not (name_match and time_match and date_match):
            self.sigError.emit("Could not build copyinfo text: datafile must contain name, date(...), and time(...).")
            return
        text = (
            f"{name_match.group(1)}_{date_match.group(1)}_{time_match.group(1)}"
            f"_({self.current_x_pixel},{self.current_y_pixel})"
        )
        self.sigCopyText.emit(text)
        self.sigLog.emit(f"Copied position info: {text}")

    @QtCore.Slot()
    def write_single_g2_coordinate(self):
        try:
            g2_coordinates.write_single_coordinate(
                x=self.current_x_pixel,
                y=self.current_y_pixel,
                timeresfile=self.analysis_params.data_file,
            )
            self.sigLog.emit(f"g2 coordinate ({self.current_x_pixel}, {self.current_y_pixel}) written")
        except Exception as exc:
            self.sigError.emit(str(exc))

    @QtCore.Slot()
    def clear_g2_coordinate_file(self):
        try:
            g2_coordinates.clear_coord_file()
            self.sigLog.emit("g2 coordinate file cleared")
        except Exception as exc:
            self.sigError.emit(str(exc))

    @QtCore.Slot()
    def find_peaks(self):
        self.sigLog.emit(
            "Find peaks requested. Full peak-analysis migration is pending; "
            "this button is wired through logic and is safe in offline mode."
        )

    @QtCore.Slot()
    def run_g2_measurement_peaks(self):
        self.sigLog.emit(
            "g2 multi-peak measurement requested. Real TimeTagger/LabJack workflow "
            "will be migrated behind a worker before hardware execution."
        )

    @QtCore.Slot()
    def run_g2_measurement_one(self):
        self.sigLog.emit(
            "g2 one-peak measurement requested. Real hardware workflow is not run "
            "from the GUI thread in this Qt increment."
        )

    @QtCore.Slot()
    def run_calibration_test(self):
        self.sigLog.emit(
            "Calibration test requested. Calibration hardware workflow is pending "
            "worker-backed migration."
        )

    @QtCore.Slot()
    def read_voltage(self):
        self.sigLog.emit("Read voltage requested. Offline dummy backend has no analog voltage readback yet.")

    @QtCore.Slot()
    def lock_center(self):
        self.center_locked = True
        self.sigLog.emit(f"Center locked at pixel ({self.current_x_pixel}, {self.current_y_pixel})")

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

    @QtCore.Slot(object)
    def _emit_image(self, image):
        self.sigImageUpdated.emit(image)
        self.sigImageReady.emit(image)

    @QtCore.Slot(object)
    def _emit_counts(self, counts):
        self.sigCountsUpdated.emit(counts)
        self.sigCountsReady.emit(counts)
