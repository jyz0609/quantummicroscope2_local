from __future__ import annotations

from qtpy import QtWidgets

from gui.scan_tab import ScanTab
from logic.models import HardwareConfig
from logic.scanner_logic import ScannerLogic


class MainWindow(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Quantum Microscope Qt")
        self.resize(1400, 950)
        self.config = HardwareConfig.load()
        self.logic = ScannerLogic(self.config, self)
        self._build_ui()
        self._connect_status()

    def _build_ui(self):
        tabs = QtWidgets.QTabWidget()
        tabs.addTab(ScanTab(self.logic, self.config), "Scan")
        self.setCentralWidget(tabs)
        self.statusBar().showMessage("Idle")

    def _connect_status(self):
        self.logic.sigStatusChanged.connect(self.statusBar().showMessage)
        self.logic.sigLog.connect(lambda message: self.statusBar().showMessage(message, 5000))
