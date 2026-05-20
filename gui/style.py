from qtpy import QtGui


APP_QSS = """
QMainWindow, QWidget {
    background: #151a20;
    color: #d9e2ec;
    font-family: Segoe UI, Arial, sans-serif;
    font-size: 10pt;
}

QGroupBox {
    border: 1px solid #2b3542;
    border-radius: 6px;
    margin-top: 14px;
    padding: 10px 8px 8px 8px;
    background: #1b222b;
}

QGroupBox::title {
    subcontrol-origin: margin;
    left: 10px;
    padding: 0 4px;
    color: #f2f6fa;
    font-weight: 600;
}

QLineEdit, QSpinBox, QDoubleSpinBox, QComboBox, QPlainTextEdit {
    background: #10151b;
    border: 1px solid #344150;
    border-radius: 4px;
    padding: 4px 6px;
    color: #eef4f8;
    selection-background-color: #2f80ed;
}

QPlainTextEdit {
    font-family: Consolas, "Courier New", monospace;
}

QPushButton {
    background: #263241;
    border: 1px solid #3a4858;
    border-radius: 5px;
    padding: 6px 10px;
    color: #f0f5f9;
}

QPushButton:hover {
    background: #304052;
}

QPushButton:pressed {
    background: #1f2a36;
}

QPushButton:disabled, QLineEdit:disabled, QSpinBox:disabled, QDoubleSpinBox:disabled {
    background: #1a2028;
    color: #7d8b99;
    border-color: #27313c;
}

QPushButton#startButton {
    background: #176b52;
    border-color: #22906f;
}

QPushButton#stopButton {
    background: #8f2d34;
    border-color: #c44852;
}

QPushButton#smallButton {
    padding: 4px 6px;
    min-width: 58px;
}

QTabWidget::pane {
    border: 1px solid #2b3542;
}

QTabBar::tab {
    background: #1b222b;
    border: 1px solid #2b3542;
    padding: 8px 14px;
}

QTabBar::tab:selected {
    background: #263241;
    color: #ffffff;
}

QStatusBar {
    background: #10151b;
    color: #cbd5df;
}

QScrollArea#controlsScroll {
    background: #151a20;
    border: none;
}

QWidget#controlsPanel {
    background: #151a20;
}

QScrollBar:vertical {
    background: #10151b;
    width: 10px;
    margin: 0;
}

QScrollBar::handle:vertical {
    background: #3a4858;
    border-radius: 5px;
    min-height: 32px;
}

QScrollBar::handle:vertical:hover {
    background: #4a5b6e;
}

QScrollBar::add-line:vertical,
QScrollBar::sub-line:vertical {
    height: 0;
    border: none;
    background: transparent;
}

QScrollBar::add-page:vertical,
QScrollBar::sub-page:vertical {
    background: transparent;
}
"""


def apply_style(app):
    app.setStyleSheet(APP_QSS)
    app.setFont(QtGui.QFont("Segoe UI", 10))
