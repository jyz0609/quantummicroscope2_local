from __future__ import annotations

from qtpy import QtWidgets


class AnalysisControlDockWidget(QtWidgets.QDockWidget):
    def __init__(self, widget: QtWidgets.QWidget, parent=None):
        super().__init__("Analysis", parent)
        self.setObjectName("analysis_control_DockWidget")
        self.setWidget(widget)
