from __future__ import annotations

from qtpy import QtWidgets


class ScanControlDockWidget(QtWidgets.QDockWidget):
    def __init__(self, widget: QtWidgets.QWidget, parent=None):
        super().__init__("Scan Control", parent)
        self.setObjectName("scan_control_DockWidget")
        self.setWidget(widget)
