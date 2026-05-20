from __future__ import annotations

from qtpy import QtWidgets


class G2ControlDockWidget(QtWidgets.QDockWidget):
    def __init__(self, widget: QtWidgets.QWidget, parent=None):
        super().__init__("g2 / Calibration", parent)
        self.setObjectName("g2_control_DockWidget")
        self.setWidget(widget)
