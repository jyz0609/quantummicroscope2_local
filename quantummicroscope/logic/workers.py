from __future__ import annotations

import logging
import traceback

from qtpy import QtCore

from quantummicroscope.interface.scanner_interface import ScanCallbacks
from quantummicroscope.logic.models import ScanParameters

LOGGER = logging.getLogger(__name__)


class ScanWorker(QtCore.QObject):
    sigLog = QtCore.Signal(str)
    sigError = QtCore.Signal(str)
    sigImageUpdated = QtCore.Signal(object)
    sigCountsUpdated = QtCore.Signal(object)
    sigFinished = QtCore.Signal(str)

    def __init__(self, scanner, counter, params: ScanParameters):
        super().__init__()
        self._scanner = scanner
        self._counter = counter
        self._params = params
        self._cancel_requested = False

    @QtCore.Slot()
    def run(self):
        try:
            callbacks = ScanCallbacks(
                image_ready=self.sigImageUpdated.emit,
                log=self.sigLog.emit,
                cancel_requested=lambda: self._cancel_requested,
            )
            image = self._scanner.start_scan(self._params, callbacks)
            self.sigImageUpdated.emit(image)
            self.sigCountsUpdated.emit(self._counter.read_counts())
            self.sigFinished.emit("Scan cancelled" if self._cancel_requested else "Scan finished")
        except Exception as exc:
            LOGGER.exception("Scan worker failed")
            self.sigError.emit(f"{exc}\n{traceback.format_exc(limit=4)}")

    @QtCore.Slot()
    def cancel(self):
        self._cancel_requested = True
        stop_scan = getattr(self._scanner, "stop_scan", None)
        if stop_scan is not None:
            stop_scan()
