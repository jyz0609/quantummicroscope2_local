from __future__ import annotations

from pathlib import Path

import numpy as np
import pyqtgraph as pg
from qtpy import QtCore, QtWidgets

from logic.models import AnalysisParameters, G2Parameters, HardwareConfig, ScanParameters
from logic.scanner_logic import ScannerLogic


class ScanTab(QtWidgets.QWidget):
    def __init__(self, logic: ScannerLogic, config: HardwareConfig, parent=None):
        super().__init__(parent)
        self.logic = logic
        self.config = config
        self._build_ui()
        self._connect_logic()
        self._load_defaults()

    def _build_ui(self):
        root = QtWidgets.QHBoxLayout(self)
        root.setContentsMargins(12, 12, 12, 12)
        root.setSpacing(12)

        controls = QtWidgets.QWidget()
        controls_layout = QtWidgets.QVBoxLayout(controls)
        controls_layout.setContentsMargins(0, 0, 0, 0)
        controls_layout.setSpacing(10)

        acquisition = self._group("Acquisition")
        form = QtWidgets.QFormLayout(acquisition)
        self.clue_edit = QtWidgets.QLineEdit()
        self.data_folder_edit = QtWidgets.QLineEdit()
        self.data_file_edit = QtWidgets.QLineEdit()
        self.speed_combo = QtWidgets.QComboBox()
        self.speed_combo.addItems(["slow", "zoom", "fast"])
        self.dim_spin = QtWidgets.QSpinBox()
        self.dim_spin.setRange(4, 4096)
        self.dwell_spin = QtWidgets.QDoubleSpinBox()
        self.dwell_spin.setRange(0.0001, 9999.0)
        self.dwell_spin.setDecimals(4)
        self.dwell_spin.setSingleStep(0.001)
        self.freq_spin = QtWidgets.QDoubleSpinBox()
        self.freq_spin.setRange(0.001, 100000.0)
        self.freq_spin.setDecimals(3)
        self.frames_spin = QtWidgets.QSpinBox()
        self.frames_spin.setRange(1, 100000)
        self.offline_check = QtWidgets.QCheckBox("Offline / dummy hardware")
        self.record_check = QtWidgets.QCheckBox("Run Scan")
        self.diagnostics_check = QtWidgets.QCheckBox("Diagnostics")
        form.addRow("Info", self.clue_edit)
        form.addRow("Data folder", self.data_folder_edit)
        form.addRow("Filename", self.data_file_edit)
        form.addRow("Mode", self.speed_combo)
        form.addRow("Dim Y/X", self.dim_spin)
        form.addRow("Dwell (s)", self.dwell_spin)
        form.addRow("Freq", self.freq_spin)
        form.addRow("Frames", self.frames_spin)
        form.addRow("", self.record_check)
        form.addRow("", self.diagnostics_check)
        form.addRow("", self.offline_check)

        scan_range = self._group("Scan Range")
        range_form = QtWidgets.QFormLayout(scan_range)
        self.amp_x_spin = self._voltage_spin()
        self.amp_y_spin = self._voltage_spin()
        self.min_x_spin = self._voltage_spin()
        self.max_x_spin = self._voltage_spin()
        self.min_y_spin = self._voltage_spin()
        self.max_y_spin = self._voltage_spin()
        self.scope_spin = QtWidgets.QDoubleSpinBox()
        self.scope_spin.setRange(0.001, 100000.0)
        self.scope_spin.setDecimals(3)
        self.lens_slope_spin = QtWidgets.QDoubleSpinBox()
        self.lens_slope_spin.setRange(0.001, 100000.0)
        self.lens_slope_spin.setDecimals(3)
        self.step_size_spin = QtWidgets.QDoubleSpinBox()
        self.step_size_spin.setRange(0.001, 100000.0)
        self.step_size_spin.setDecimals(3)
        range_form.addRow("Amp X", self.amp_x_spin)
        range_form.addRow("Amp Y", self.amp_y_spin)
        range_form.addRow("Min X", self.min_x_spin)
        range_form.addRow("Max X", self.max_x_spin)
        range_form.addRow("Min Y", self.min_y_spin)
        range_form.addRow("Max Y", self.max_y_spin)
        range_form.addRow("Length um", self.scope_spin)
        range_form.addRow("Lens slope", self.lens_slope_spin)
        range_form.addRow("Step nm", self.step_size_spin)

        motion = self._group("Motion")
        motion_layout = QtWidgets.QGridLayout(motion)
        self.x_pixel_spin = QtWidgets.QSpinBox()
        self.x_pixel_spin.setRange(0, 4095)
        self.y_pixel_spin = QtWidgets.QSpinBox()
        self.y_pixel_spin.setRange(0, 4095)
        self.move_button = QtWidgets.QPushButton("Move")
        self.center_button = QtWidgets.QPushButton("Center")
        motion_layout.addWidget(QtWidgets.QLabel("X pixel"), 0, 0)
        motion_layout.addWidget(self.x_pixel_spin, 0, 1)
        motion_layout.addWidget(QtWidgets.QLabel("Y pixel"), 1, 0)
        motion_layout.addWidget(self.y_pixel_spin, 1, 1)
        motion_layout.addWidget(self.move_button, 2, 0)
        motion_layout.addWidget(self.center_button, 2, 1)

        analysis = self._group("Analysis")
        analysis_form = QtWidgets.QFormLayout(analysis)
        self.analysis_file_edit = QtWidgets.QLineEdit()
        self.recipe_edit = QtWidgets.QLineEdit()
        self.save_folder_edit = QtWidgets.QLineEdit()
        self.bins_spin = QtWidgets.QSpinBox()
        self.bins_spin.setRange(1, 100000000)
        self.channel_edit = QtWidgets.QLineEdit()
        analysis_form.addRow("Datafile", self.analysis_file_edit)
        analysis_form.addRow("ETA recipe", self.recipe_edit)
        analysis_form.addRow("Save folder", self.save_folder_edit)
        analysis_form.addRow("Bins", self.bins_spin)
        analysis_form.addRow("Channel", self.channel_edit)

        g2 = self._group("g2 / Calibration")
        g2_form = QtWidgets.QFormLayout(g2)
        self.g2_time_spin = QtWidgets.QSpinBox()
        self.g2_time_spin.setRange(1, 10000000)
        self.calibration_interval_spin = QtWidgets.QSpinBox()
        self.calibration_interval_spin.setRange(1, 10000000)
        self.do_calibration_check = QtWidgets.QCheckBox("Do calibration scans")
        self.peak_number_spin = QtWidgets.QSpinBox()
        self.peak_number_spin.setRange(1, 1000000)
        self.multi_peak_check = QtWidgets.QCheckBox("Enable g2 multiple peaks")
        self.average_count_spin = QtWidgets.QSpinBox()
        self.average_count_spin.setRange(1, 100000000)
        g2_form.addRow("Measurement time", self.g2_time_spin)
        g2_form.addRow("Calibration interval", self.calibration_interval_spin)
        g2_form.addRow("", self.do_calibration_check)
        g2_form.addRow("Peak number", self.peak_number_spin)
        g2_form.addRow("", self.multi_peak_check)
        g2_form.addRow("Average count/bin", self.average_count_spin)

        actions = QtWidgets.QWidget()
        actions_layout = QtWidgets.QGridLayout(actions)
        actions_layout.setContentsMargins(0, 0, 0, 0)
        self.filename_button = QtWidgets.QPushButton("Filename")
        self.start_button = QtWidgets.QPushButton("Start Scan")
        self.start_button.setObjectName("startButton")
        self.stop_button = QtWidgets.QPushButton("Stop")
        self.stop_button.setObjectName("stopButton")
        self.analyze_button = QtWidgets.QPushButton("Analyze")
        self.count_button = QtWidgets.QPushButton("Signal Counter")
        actions_layout.addWidget(self.filename_button, 0, 0)
        actions_layout.addWidget(self.start_button, 0, 1)
        actions_layout.addWidget(self.stop_button, 0, 2)
        actions_layout.addWidget(self.analyze_button, 1, 0, 1, 2)
        actions_layout.addWidget(self.count_button, 1, 2)

        controls_layout.addWidget(acquisition)
        controls_layout.addWidget(scan_range)
        controls_layout.addWidget(motion)
        controls_layout.addWidget(analysis)
        controls_layout.addWidget(g2)
        controls_layout.addWidget(actions)
        controls_layout.addStretch(1)

        display = QtWidgets.QWidget()
        display_layout = QtWidgets.QVBoxLayout(display)
        display_layout.setContentsMargins(0, 0, 0, 0)
        display_layout.setSpacing(10)

        self.image_view = pg.ImageView()
        self.image_view.ui.roiBtn.hide()
        self.image_view.ui.menuBtn.hide()
        display_layout.addWidget(self.image_view, 6)

        bottom = QtWidgets.QHBoxLayout()
        self.counts_table = QtWidgets.QTableWidget(4, 2)
        self.counts_table.setHorizontalHeaderLabels(["Channel", "Counts"])
        self.counts_table.verticalHeader().hide()
        self.counts_table.horizontalHeader().setStretchLastSection(True)
        for row, channel in enumerate(range(1, 5)):
            self.counts_table.setItem(row, 0, QtWidgets.QTableWidgetItem(str(channel)))
            self.counts_table.setItem(row, 1, QtWidgets.QTableWidgetItem(""))
        self.log_edit = QtWidgets.QPlainTextEdit()
        self.log_edit.setReadOnly(True)
        bottom.addWidget(self.counts_table, 1)
        bottom.addWidget(self.log_edit, 3)
        display_layout.addLayout(bottom, 2)

        root.addWidget(controls, 0)
        root.addWidget(display, 1)

        self.filename_button.clicked.connect(self._submit_and_suggest_filename)
        self.start_button.clicked.connect(self._start_scan)
        self.stop_button.clicked.connect(self.logic.cancel_scan)
        self.analyze_button.clicked.connect(self._analyze)
        self.count_button.clicked.connect(self.logic.count_signals)
        self.move_button.clicked.connect(self._move_to_pixel)
        self.center_button.clicked.connect(lambda: self._move_to_pixel(center=True))
        for widget in [
            self.dim_spin,
            self.amp_x_spin,
            self.amp_y_spin,
            self.lens_slope_spin,
            self.scope_spin,
        ]:
            widget.valueChanged.connect(self._sync_derived_ranges)

    def _group(self, title: str) -> QtWidgets.QGroupBox:
        return QtWidgets.QGroupBox(title)

    def _voltage_spin(self) -> QtWidgets.QDoubleSpinBox:
        spin = QtWidgets.QDoubleSpinBox()
        spin.setRange(-10.0, 10.0)
        spin.setDecimals(5)
        spin.setSingleStep(0.01)
        return spin

    def _connect_logic(self):
        self.logic.sigLog.connect(self.append_log)
        self.logic.sigError.connect(self.show_error)
        self.logic.sigImageReady.connect(self.update_image)
        self.logic.sigCountsReady.connect(self.update_counts)
        self.logic.sigSuggestedFilename.connect(self.data_file_edit.setText)
        self.logic.sigScanStarted.connect(lambda: self._set_running(True))
        self.logic.sigScanFinished.connect(lambda _message: self._set_running(False))

    def _load_defaults(self):
        scan = self.logic.scan_params
        analysis = self.logic.analysis_params
        g2 = self.logic.g2_params
        self.clue_edit.setText(scan.clue)
        self.data_folder_edit.setText(scan.data_folder)
        self.data_file_edit.setText(scan.data_file)
        self.speed_combo.setCurrentText(scan.speed_mode)
        self.dim_spin.setValue(scan.dim_y)
        self.dwell_spin.setValue(scan.int_time)
        self.freq_spin.setValue(scan.freq)
        self.frames_spin.setValue(scan.nr_frames)
        self.record_check.setChecked(scan.record_scan)
        self.diagnostics_check.setChecked(scan.diagnostics_mode)
        self.offline_check.setChecked(scan.offline_mode)
        self.amp_x_spin.setValue(scan.amp_x)
        self.amp_y_spin.setValue(scan.amp_y)
        self.min_x_spin.setValue(scan.min_x)
        self.max_x_spin.setValue(scan.max_x)
        self.min_y_spin.setValue(scan.min_y)
        self.max_y_spin.setValue(scan.max_y)
        self.scope_spin.setValue(scan.scope_length)
        self.lens_slope_spin.setValue(scan.lens_slope)
        self.step_size_spin.setValue(scan.step_size_nm)
        self.x_pixel_spin.setValue(1)
        self.y_pixel_spin.setValue(1)
        self.analysis_file_edit.setText(analysis.data_file)
        self.recipe_edit.setText(analysis.eta_recipe)
        self.save_folder_edit.setText(analysis.save_folder)
        self.bins_spin.setValue(analysis.bins)
        self.channel_edit.setText(analysis.channel_selection)
        self.g2_time_spin.setValue(g2.measuring_time)
        self.calibration_interval_spin.setValue(g2.calibration_interval_time)
        self.do_calibration_check.setChecked(g2.do_calibration)
        self.peak_number_spin.setValue(g2.find_peak_number)
        self.multi_peak_check.setChecked(g2.enable_multi_peak_measurement)
        self.average_count_spin.setValue(g2.average_count_per_bin)

    def _read_scan_params(self) -> ScanParameters:
        return ScanParameters(
            clue=self.clue_edit.text().strip() or "scan",
            data_folder=self.data_folder_edit.text().strip(),
            data_file=self.data_file_edit.text().strip(),
            speed_mode=self.speed_combo.currentText(),
            dim_y=self.dim_spin.value(),
            int_time=self.dwell_spin.value(),
            freq=self.freq_spin.value(),
            nr_frames=self.frames_spin.value(),
            amp_x=self.amp_x_spin.value(),
            amp_y=self.amp_y_spin.value(),
            min_x=self.min_x_spin.value(),
            max_x=self.max_x_spin.value(),
            min_y=self.min_y_spin.value(),
            max_y=self.max_y_spin.value(),
            scope_length=self.scope_spin.value(),
            lens_slope=self.lens_slope_spin.value(),
            step_size_nm=self.step_size_spin.value(),
            record_scan=self.record_check.isChecked(),
            diagnostics_mode=self.diagnostics_check.isChecked(),
            offline_mode=self.offline_check.isChecked(),
        )

    def _read_analysis_params(self) -> AnalysisParameters:
        return AnalysisParameters(
            data_file=self.analysis_file_edit.text().strip(),
            eta_recipe=self.recipe_edit.text().strip(),
            save_folder=self.save_folder_edit.text().strip(),
            bins=self.bins_spin.value(),
            channel_selection=self.channel_edit.text().strip(),
        )

    def _read_g2_params(self) -> G2Parameters:
        return G2Parameters(
            measuring_time=self.g2_time_spin.value(),
            calibration_interval_time=self.calibration_interval_spin.value(),
            do_calibration=self.do_calibration_check.isChecked(),
            find_peak_number=self.peak_number_spin.value(),
            enable_multi_peak_measurement=self.multi_peak_check.isChecked(),
            average_count_per_bin=self.average_count_spin.value(),
        )

    def _submit_forms(self):
        self.logic.update_scan_parameters(self._read_scan_params())
        self.logic.update_analysis_parameters(self._read_analysis_params())
        self.logic.update_g2_parameters(self._read_g2_params())

    def _submit_and_suggest_filename(self):
        self._submit_forms()
        self.logic.suggest_filename()

    def _start_scan(self):
        self._submit_forms()
        self.logic.start_scan()

    def _analyze(self):
        self._submit_forms()
        self.logic.analyze_current_file()

    def _move_to_pixel(self, center: bool = False):
        self._submit_forms()
        if center:
            midpoint = max(0, self.dim_spin.value() // 2)
            self.x_pixel_spin.setValue(midpoint)
            self.y_pixel_spin.setValue(midpoint)
        self.logic.move_to_pixel(self.x_pixel_spin.value(), self.y_pixel_spin.value())

    def _sync_derived_ranges(self):
        amp_x = self.amp_x_spin.value()
        amp_y = self.amp_y_spin.value()
        slope = self.lens_slope_spin.value()
        self.min_x_spin.blockSignals(True)
        self.max_x_spin.blockSignals(True)
        self.min_y_spin.blockSignals(True)
        self.max_y_spin.blockSignals(True)
        self.step_size_spin.blockSignals(True)
        self.scope_spin.blockSignals(True)
        self.min_x_spin.setValue(round(-amp_x + self.config.x_offset, 5))
        self.max_x_spin.setValue(round(amp_x + self.config.x_offset, 5))
        self.min_y_spin.setValue(round(-amp_y + self.config.y_offset, 5))
        self.max_y_spin.setValue(round(amp_y + self.config.y_offset, 5))
        scope = round(amp_x * slope, 3)
        self.scope_spin.setValue(scope)
        self.step_size_spin.setValue(round(scope * 1000 / max(1, self.dim_spin.value()), 3))
        self.min_x_spin.blockSignals(False)
        self.max_x_spin.blockSignals(False)
        self.min_y_spin.blockSignals(False)
        self.max_y_spin.blockSignals(False)
        self.step_size_spin.blockSignals(False)
        self.scope_spin.blockSignals(False)

    @QtCore.Slot(str)
    def append_log(self, message: str):
        self.log_edit.appendPlainText(message)

    @QtCore.Slot(str)
    def show_error(self, message: str):
        self.append_log(f"ERROR: {message}")
        QtWidgets.QMessageBox.critical(self, "Quantum Microscope Error", message)
        self._set_running(False)

    @QtCore.Slot(object)
    def update_image(self, image):
        array = np.asarray(image, dtype=float)
        self.image_view.setImage(array.T, autoLevels=True, autoRange=True)

    @QtCore.Slot(object)
    def update_counts(self, counts: dict):
        for row, channel in enumerate(range(1, 5)):
            value = counts.get(channel, "")
            self.counts_table.setItem(row, 1, QtWidgets.QTableWidgetItem(str(value)))

    def _set_running(self, running: bool):
        self.start_button.setEnabled(not running)
        self.analyze_button.setEnabled(not running)
        self.stop_button.setEnabled(running)
