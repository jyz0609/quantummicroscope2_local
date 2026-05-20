from __future__ import annotations

from qtpy import QtCore, QtGui, QtWidgets

from quantummicroscope.gui.scanner_gui import ScannerGui
from quantummicroscope.logic.models import HardwareConfig
from quantummicroscope.logic.scanner_logic import ScannerLogic


class QuantumMicroscopeMainWindow(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Quantum Microscope Qt")
        self.resize(1400, 950)
        self.config = HardwareConfig.load()
        self.logic = ScannerLogic(self.config, self)
        self.scanner_gui = ScannerGui(self.logic, self.config, self)
        self._build_ui()
        self._connect_status()

    def _build_ui(self):
        self.setCentralWidget(QtWidgets.QWidget(self))
        self._build_actions()
        self._build_toolbar()
        self._build_docks()
        self.statusBar().showMessage("Idle")

    def _build_actions(self):
        self.scan_start_Action = QtGui.QAction("Start Scan", self)
        self.scan_start_Action.triggered.connect(self.scanner_gui._start_scan)
        self.scan_start_Action.setObjectName("scan_start_Action")

        self.scan_stop_Action = QtGui.QAction("Stop", self)
        self.scan_stop_Action.triggered.connect(self.logic.cancel_scan)
        self.scan_stop_Action.setObjectName("scan_stop_Action")

        self.scan_filename_Action = QtGui.QAction("Filename", self)
        self.scan_filename_Action.triggered.connect(self.scanner_gui._submit_and_suggest_filename)
        self.scan_filename_Action.setObjectName("scan_filename_Action")

        self.analysis_run_Action = QtGui.QAction("Analyze", self)
        self.analysis_run_Action.triggered.connect(self.scanner_gui._analyze)
        self.analysis_run_Action.setObjectName("analysis_run_Action")

        self.counter_update_Action = QtGui.QAction("Signal Counter", self)
        self.counter_update_Action.triggered.connect(self.logic.count_signals)
        self.counter_update_Action.setObjectName("counter_update_Action")

    def _build_toolbar(self):
        self.scan_ToolBar = self.addToolBar("Scan")
        self.scan_ToolBar.setObjectName("scan_ToolBar")
        self.scan_ToolBar.addAction(self.scan_filename_Action)
        self.scan_ToolBar.addAction(self.scan_start_Action)
        self.scan_ToolBar.addAction(self.scan_stop_Action)
        self.scan_ToolBar.addSeparator()
        self.scan_ToolBar.addAction(self.analysis_run_Action)
        self.scan_ToolBar.addAction(self.counter_update_Action)

    def _build_docks(self):
        self.view_Menu = self.menuBar().addMenu("View")
        self.scanner_DockWidget = QtWidgets.QDockWidget("Scanner", self)
        self.scanner_DockWidget.setObjectName("scanner_DockWidget")
        self.scanner_DockWidget.setWidget(self.scanner_gui)
        self.scanner_DockWidget.setAllowedAreas(
            QtCore.Qt.LeftDockWidgetArea | QtCore.Qt.RightDockWidgetArea | QtCore.Qt.BottomDockWidgetArea
        )
        self.addDockWidget(QtCore.Qt.LeftDockWidgetArea, self.scanner_DockWidget)
        self.view_Menu.addAction(self.scanner_DockWidget.toggleViewAction())

    def _connect_status(self):
        self.logic.sigStatusChanged.connect(self.statusBar().showMessage)
        self.logic.sigLog.connect(lambda message: self.statusBar().showMessage(message, 5000))


MainWindow = QuantumMicroscopeMainWindow
