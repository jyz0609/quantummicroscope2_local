from __future__ import annotations

from qtpy import QtWidgets


class LogDockWidget(QtWidgets.QDockWidget):
    def __init__(self, widget: QtWidgets.QWidget, parent=None):
        super().__init__("Log", parent)
        self.setObjectName("log_DockWidget")
        self.setWidget(widget)
