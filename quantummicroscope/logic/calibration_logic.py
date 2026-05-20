from __future__ import annotations

from qtpy import QtCore

from quantummicroscope.core.module import BaseModule


class CalibrationLogic(BaseModule):
    sigLog = QtCore.Signal(str)

    @QtCore.Slot()
    def run_calibration_test(self) -> None:
        self.sigLog.emit("Calibration workflow is ready for worker-backed hardware migration.")
