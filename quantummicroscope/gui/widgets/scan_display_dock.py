from __future__ import annotations

from qtpy import QtWidgets


class ScanDisplayDockWidget(QtWidgets.QDockWidget):
    def __init__(self, widget: QtWidgets.QWidget, parent=None):
        super().__init__("Scan Display", parent)
        self.setObjectName("scan_display_DockWidget")
        self.setWidget(widget)
