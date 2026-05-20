from __future__ import annotations

import numpy as np
import pyqtgraph as pg
from qtpy import QtCore, QtWidgets

from quantummicroscope.logic.models import AnalysisParameters, G2Parameters, HardwareConfig, ScanParameters
from quantummicroscope.logic.scanner_logic import ScannerLogic


class ScannerGui(QtWidgets.QWidget):
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
        controls.setObjectName("controlsPanel")
        controls.setMinimumWidth(340)
        controls_layout = QtWidgets.QVBoxLayout(controls)
        controls_layout.setContentsMargins(8, 8, 8, 8)
        controls_layout.setSpacing(8)

        controls_scroll = QtWidgets.QScrollArea()
        controls_scroll.setObjectName("controlsScroll")
        controls_scroll.setWidgetResizable(True)
        controls_scroll.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        controls_scroll.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAsNeeded)
        controls_scroll.setFrameShape(QtWidgets.QFrame.NoFrame)
        controls_scroll.setMinimumWidth(360)
        controls_scroll.setMaximumWidth(460)
        controls_scroll.setWidget(controls)

        acquisition = self._group("Acquisition")
        form = QtWidgets.QFormLayout(acquisition)
        self._configure_form(form)
        self.clue_edit = QtWidgets.QLineEdit()
        self.data_folder_edit = QtWidgets.QLineEdit()
        self.data_file_edit = QtWidgets.QLineEdit()
        self._configure_path_edit(self.data_folder_edit, "Folder where scan data is written")
        self._configure_path_edit(self.data_file_edit, "Generated scan filename")
        self.data_folder_browse = QtWidgets.QPushButton("Browse")
        self.data_folder_browse.setObjectName("smallButton")
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
        form.addRow("Data folder", self._path_row(self.data_folder_edit, self.data_folder_browse))
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
        self._configure_form(range_form)
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
        self.set_50_button = QtWidgets.QPushButton("Set 50")
        self.set_50_button.setObjectName("smallButton")
        self.set_100_button = QtWidgets.QPushButton("Set 100")
        self.set_100_button.setObjectName("smallButton")
        self.step_set_button = QtWidgets.QPushButton("Step Set")
        self.step_set_button.setObjectName("smallButton")
        self.step_get_button = QtWidgets.QPushButton("Step Get")
        self.step_get_button.setObjectName("smallButton")
        range_buttons = QtWidgets.QGridLayout()
        range_buttons.setContentsMargins(0, 0, 0, 0)
        range_buttons.setSpacing(6)
        range_buttons.addWidget(self.set_50_button, 0, 0)
        range_buttons.addWidget(self.set_100_button, 0, 1)
        range_buttons.addWidget(self.step_set_button, 1, 0)
        range_buttons.addWidget(self.step_get_button, 1, 1)
        range_form.addRow("Helpers", range_buttons)

        motion = self._group("Motion")
        motion_layout = QtWidgets.QGridLayout(motion)
        self.x_pixel_spin = QtWidgets.QSpinBox()
        self.x_pixel_spin.setRange(0, 4095)
        self.y_pixel_spin = QtWidgets.QSpinBox()
        self.y_pixel_spin.setRange(0, 4095)
        self.move_button = QtWidgets.QPushButton("Move")
        self.center_button = QtWidgets.QPushButton("Center")
        self.copy_info_button = QtWidgets.QPushButton("Copy Info")
        self.read_voltage_button = QtWidgets.QPushButton("Read Voltage")
        self.lock_center_button = QtWidgets.QPushButton("Lock Center")
        motion_layout.addWidget(QtWidgets.QLabel("X pixel"), 0, 0)
        motion_layout.addWidget(self.x_pixel_spin, 0, 1)
        motion_layout.addWidget(QtWidgets.QLabel("Y pixel"), 1, 0)
        motion_layout.addWidget(self.y_pixel_spin, 1, 1)
        motion_layout.addWidget(self.move_button, 2, 0)
        motion_layout.addWidget(self.center_button, 2, 1)
        motion_layout.addWidget(self.copy_info_button, 3, 0)
        motion_layout.addWidget(self.read_voltage_button, 3, 1)
        motion_layout.addWidget(self.lock_center_button, 4, 0, 1, 2)

        analysis = self._group("Analysis")
        analysis_form = QtWidgets.QFormLayout(analysis)
        self._configure_form(analysis_form)
        self.analysis_file_edit = QtWidgets.QLineEdit()
        self.recipe_edit = QtWidgets.QLineEdit()
        self.save_folder_edit = QtWidgets.QLineEdit()
        self._configure_path_edit(self.analysis_file_edit, "Timeres file to analyze")
        self._configure_path_edit(self.recipe_edit, "ETA recipe file")
        self._configure_path_edit(self.save_folder_edit, "Analysis output folder")
        self.analysis_file_browse = QtWidgets.QPushButton("Browse")
        self.analysis_file_browse.setObjectName("smallButton")
        self.recipe_browse = QtWidgets.QPushButton("Browse")
        self.recipe_browse.setObjectName("smallButton")
        self.save_folder_browse = QtWidgets.QPushButton("Browse")
        self.save_folder_browse.setObjectName("smallButton")
        self.bins_spin = QtWidgets.QSpinBox()
        self.bins_spin.setRange(1, 100000000)
        self.channel_edit = QtWidgets.QLineEdit()
        analysis_form.addRow("Datafile", self._path_row(self.analysis_file_edit, self.analysis_file_browse))
        analysis_form.addRow("ETA recipe", self._path_row(self.recipe_edit, self.recipe_browse))
        analysis_form.addRow("Save folder", self._path_row(self.save_folder_edit, self.save_folder_browse))
        analysis_form.addRow("Bins", self.bins_spin)
        analysis_form.addRow("Channel", self.channel_edit)

        g2 = self._group("g2 / Calibration")
        g2_form = QtWidgets.QFormLayout(g2)
        self._configure_form(g2_form)
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
        self.g2_write_coord_button = QtWidgets.QPushButton("Single Coord Record")
        self.g2_clear_coord_button = QtWidgets.QPushButton("Clear Coord File")
        self.find_peaks_button = QtWidgets.QPushButton("Find Peaks")
        self.g2_peaks_button = QtWidgets.QPushButton("g2 Measurement Peaks")
        self.g2_one_button = QtWidgets.QPushButton("g2 Measurement One")
        self.calibration_test_button = QtWidgets.QPushButton("Run Calibration Test")
        g2_buttons = QtWidgets.QGridLayout()
        g2_buttons.setContentsMargins(0, 0, 0, 0)
        g2_buttons.setSpacing(6)
        g2_buttons.addWidget(self.g2_write_coord_button, 0, 0)
        g2_buttons.addWidget(self.g2_clear_coord_button, 0, 1)
        g2_buttons.addWidget(self.find_peaks_button, 1, 0)
        g2_buttons.addWidget(self.g2_peaks_button, 1, 1)
        g2_buttons.addWidget(self.g2_one_button, 2, 0)
        g2_buttons.addWidget(self.calibration_test_button, 2, 1)
        g2_form.addRow("Actions", g2_buttons)

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
        self.image_view.setMinimumSize(520, 420)
        display_layout.addWidget(self.image_view, 6)

        bottom = QtWidgets.QHBoxLayout()
        self.counts_table = QtWidgets.QTableWidget(4, 2)
        self.counts_table.setMinimumHeight(150)
        self.counts_table.setMaximumHeight(220)
        self.counts_table.setHorizontalHeaderLabels(["Channel", "Counts"])
        self.counts_table.verticalHeader().hide()
        self.counts_table.horizontalHeader().setStretchLastSection(True)
        for row, channel in enumerate(range(1, 5)):
            self.counts_table.setItem(row, 0, QtWidgets.QTableWidgetItem(str(channel)))
            self.counts_table.setItem(row, 1, QtWidgets.QTableWidgetItem(""))
        self.log_edit = QtWidgets.QPlainTextEdit()
        self.log_edit.setReadOnly(True)
        self.log_edit.setMinimumHeight(150)
        bottom.addWidget(self.counts_table, 1)
        bottom.addWidget(self.log_edit, 3)
        display_layout.addLayout(bottom, 2)

        root.addWidget(controls_scroll, 0)
        root.addWidget(display, 1)

        self.filename_button.clicked.connect(self._submit_and_suggest_filename)
        self.data_folder_browse.clicked.connect(
            lambda: self._browse_directory(self.data_folder_edit, "Select data folder")
        )
        self.analysis_file_browse.clicked.connect(
            lambda: self._browse_file(self.analysis_file_edit, "Select timeres file", "Timeres (*.timeres);;All files (*)")
        )
        self.recipe_browse.clicked.connect(
            lambda: self._browse_file(self.recipe_edit, "Select ETA recipe", "ETA recipe (*.eta);;All files (*)")
        )
        self.save_folder_browse.clicked.connect(
            lambda: self._browse_directory(self.save_folder_edit, "Select analysis save folder")
        )
        self.start_button.clicked.connect(self._start_scan)
        self.stop_button.clicked.connect(self.logic.cancel_scan)
        self.analyze_button.clicked.connect(self._analyze)
        self.count_button.clicked.connect(self.logic.count_signals)
        self.move_button.clicked.connect(self._move_to_pixel)
        self.center_button.clicked.connect(lambda: self._move_to_pixel(center=True))
        self.copy_info_button.clicked.connect(self._copy_position_info)
        self.read_voltage_button.clicked.connect(self._read_voltage)
        self.lock_center_button.clicked.connect(self._lock_center)
        self.set_50_button.clicked.connect(lambda: self._set_scope_length(50.0))
        self.set_100_button.clicked.connect(lambda: self._set_scope_length(100.0))
        self.step_set_button.clicked.connect(self._set_step_size_from_field)
        self.step_get_button.clicked.connect(self._get_step_size_from_dim)
        self.g2_write_coord_button.clicked.connect(self._write_single_g2_coordinate)
        self.g2_clear_coord_button.clicked.connect(self.logic.clear_g2_coordinate_file)
        self.find_peaks_button.clicked.connect(self._find_peaks)
        self.g2_peaks_button.clicked.connect(self._run_g2_measurement_peaks)
        self.g2_one_button.clicked.connect(self._run_g2_measurement_one)
        self.calibration_test_button.clicked.connect(self._run_calibration_test)
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

    def _configure_form(self, form: QtWidgets.QFormLayout):
        form.setFieldGrowthPolicy(QtWidgets.QFormLayout.AllNonFixedFieldsGrow)
        form.setLabelAlignment(QtCore.Qt.AlignLeft)
        form.setFormAlignment(QtCore.Qt.AlignTop)
        form.setHorizontalSpacing(10)
        form.setVerticalSpacing(6)

    def _configure_path_edit(self, edit: QtWidgets.QLineEdit, placeholder: str):
        edit.setMinimumWidth(190)
        edit.setPlaceholderText(placeholder)
        edit.setToolTip(placeholder)

    def _path_row(self, edit: QtWidgets.QLineEdit, button: QtWidgets.QPushButton) -> QtWidgets.QWidget:
        row = QtWidgets.QWidget()
        layout = QtWidgets.QHBoxLayout(row)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(6)
        button.setFixedWidth(72)
        layout.addWidget(edit, 1)
        layout.addWidget(button, 0)
        return row

    def _voltage_spin(self) -> QtWidgets.QDoubleSpinBox:
        spin = QtWidgets.QDoubleSpinBox()
        spin.setRange(-10.0, 10.0)
        spin.setDecimals(5)
        spin.setSingleStep(0.01)
        return spin

    def _connect_logic(self):
        self.logic.sigLog.connect(self.append_log)
        self.logic.sigError.connect(self.show_error)
        self.logic.sigImageUpdated.connect(self.update_image)
        self.logic.sigCountsUpdated.connect(self.update_counts)
        self.logic.sigSuggestedFilename.connect(self.data_file_edit.setText)
        self.logic.sigCopyText.connect(self._copy_text_to_clipboard)
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
        self.logic.update_current_position(self.x_pixel_spin.value(), self.y_pixel_spin.value())

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
            self._submit_forms()
        self.logic.move_to_pixel(self.x_pixel_spin.value(), self.y_pixel_spin.value())

    def _browse_directory(self, target: QtWidgets.QLineEdit, title: str):
        start_dir = self._dialog_start_dir(target)
        selected = QtWidgets.QFileDialog.getExistingDirectory(self, title, start_dir)
        if selected:
            target.setText(selected)
            self._submit_forms()

    def _browse_file(self, target: QtWidgets.QLineEdit, title: str, file_filter: str):
        start_dir = self._dialog_start_dir(target)
        selected, _filter = QtWidgets.QFileDialog.getOpenFileName(self, title, start_dir, file_filter)
        if selected:
            target.setText(selected)
            self._submit_forms()

    def _dialog_start_dir(self, edit: QtWidgets.QLineEdit) -> str:
        text = edit.text().strip()
        if not text:
            return ""
        info = QtCore.QFileInfo(text)
        if info.isDir():
            return info.absoluteFilePath()
        if info.absoluteDir().exists():
            return info.absoluteDir().absolutePath()
        return ""

    def _set_scope_length(self, value: float):
        self.scope_spin.setValue(value)
        slope = self.lens_slope_spin.value()
        if slope:
            amp = round(value / slope, 5)
            self.amp_x_spin.setValue(amp)
            self.amp_y_spin.setValue(amp)
        self._sync_derived_ranges()
        self._submit_forms()
        self.logic.set_scope_length(value)

    def _set_step_size_from_field(self):
        step = self.step_size_spin.value()
        if step > 0:
            dim = max(4, round(self.scope_spin.value() * 1000 / step))
            self.dim_spin.setValue(dim)
        self._submit_forms()
        self.logic.set_step_size_nm(step)

    def _get_step_size_from_dim(self):
        step = round(self.scope_spin.value() * 1000 / max(1, self.dim_spin.value()), 3)
        self.step_size_spin.setValue(step)
        self._submit_forms()
        self.logic.set_step_size_nm(step)

    def _copy_position_info(self):
        self._submit_forms()
        self.logic.copy_position_info()

    def _read_voltage(self):
        self._submit_forms()
        self.logic.read_voltage()

    def _lock_center(self):
        self._submit_forms()
        self.logic.lock_center()

    def _write_single_g2_coordinate(self):
        self._submit_forms()
        self.logic.write_single_g2_coordinate()

    def _find_peaks(self):
        self._submit_forms()
        self.logic.find_peaks()

    def _run_g2_measurement_peaks(self):
        self._submit_forms()
        self.logic.run_g2_measurement_peaks()

    def _run_g2_measurement_one(self):
        self._submit_forms()
        self.logic.run_g2_measurement_one()

    def _run_calibration_test(self):
        self._submit_forms()
        self.logic.run_calibration_test()

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

    @QtCore.Slot(str)
    def _copy_text_to_clipboard(self, text: str):
        QtWidgets.QApplication.clipboard().setText(text)

    def _set_running(self, running: bool):
        self.start_button.setEnabled(not running)
        self.analyze_button.setEnabled(not running)
        self.stop_button.setEnabled(running)
