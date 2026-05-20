from __future__ import annotations

import numpy as np
from qtpy import QtCore

from quantummicroscope.core.module import BaseModule
from quantummicroscope.logic.models import AnalysisParameters


class AnalysisLogic(BaseModule):
    sigImageUpdated = QtCore.Signal(object)

    @QtCore.Slot(object)
    def analyze_file(self, params: AnalysisParameters):
        dim = 100
        axis = np.linspace(-1.0, 1.0, dim)
        xx, yy = np.meshgrid(axis, axis)
        image = np.exp(-((xx + 0.25) ** 2 + (yy - 0.15) ** 2) * 10.0)
        self.sigImageUpdated.emit(image)
        return image
