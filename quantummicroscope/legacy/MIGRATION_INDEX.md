# Migration Index

This index maps old Python files to their Qudi-like locations after the direct
rename/move restructure. Function bodies were preserved where practical; imports
were updated only where needed for package organization and smoke imports.

## Application Entry Points

| Old path | New path | Notes |
| --- | --- | --- |
| `qt_app.py` | `qt_app.py` -> `quantummicroscope.app` | Compatibility entrypoint now delegates to the package app. |
| `run_qt_gui.bat` | `run_qt_gui.bat` | Now launches `python -m quantummicroscope.app`. |
| `microscope_table_setup.json` | `quantummicroscope/config/microscope_table_setup.json` | Hardware table calibration/config. |
| `microscope_control_bluefors_scan_setup.json` | `quantummicroscope/config/microscope_control_bluefors_scan_setup.json` | Scan setup config. |
| `gui/main_window.py` | `quantummicroscope/gui/main_window.py` | `MainWindow` renamed to `QuantumMicroscopeMainWindow`; `MainWindow` remains an alias. |
| `gui/scan_tab.py` | `quantummicroscope/gui/scanner_gui.py` | `ScanTab` renamed to `ScannerGui`. |
| `gui/style.py` | `quantummicroscope/gui/style.py` | Qt stylesheet moved unchanged. |

## Logic and Hardware

| Old path | New path | Notes |
| --- | --- | --- |
| `logic/models.py` | `quantummicroscope/logic/models.py` | Config loading now reads from `quantummicroscope/config/`. |
| `logic/scanner_logic.py` | `quantummicroscope/logic/scanner_logic.py` | Now uses Qudi-like connectors and worker module. |
| `hardware/dummy_hardware.py` | `quantummicroscope/hardware/scanner/dummy_scanner_hardware.py` | `DummyMicroscopeHardware` renamed to `DummyScannerHardware`. |
| `hardware/labjack_t7.py` | `quantummicroscope/hardware/labjack/labjack_t7.py` | `LabJackT7Hardware` renamed to `LabJackT7`. |
| `swabian_countrate.py` | `quantummicroscope/hardware/timetagger/swabian_countrate.py` | TimeTagger import is guarded for offline imports. |
| `mymodule/Swabian_measurement.py` | `quantummicroscope/hardware/timetagger/swabian_timetagger.py` | Existing `run_swabian` class preserved. |
| `mymodule/Swbianfilewritertest1212.py` | `quantummicroscope/hardware/timetagger/swabian_filewriter_test.py` | Import side effects guarded. |

## Analysis Utilities

| Old path | New path | Notes |
| --- | --- | --- |
| `image_analysis.py` | `quantummicroscope/analysis/image_processing.py` | Image/peak helper functions preserved. |
| `peak_analysis.py` | `quantummicroscope/analysis/peak_analysis.py` | Canonical peak-analysis module. |
| `mymodule/peak_analysis.py` | `quantummicroscope/legacy/mymodule_peak_analysis.py` | Duplicate preserved for reference. |
| `filename_process.py` | `quantummicroscope/analysis/filename_tools.py` | Filename parsing helpers preserved. |
| `g2_coord.py` | `quantummicroscope/analysis/g2_coordinates.py` | Coordinate file helpers preserved. |
| `Swabian_Microscope_library.py` | `quantummicroscope/analysis/swabian_image_analysis.py` | Swabian/ETA image analysis helpers preserved. |
| `mymodule/ETA_analysis.py` | `quantummicroscope/analysis/eta_analysis.py` | ETA analysis helpers preserved. |
| `mymodule/CNN_classifier.py` | `quantummicroscope/analysis/cnn_classifier.py` | CNN classifier helper preserved. |
| `3Dheatmap_with_recipe.py` | `quantummicroscope/analysis/heatmap_viewer.py` | Tk heatmap viewer preserved as an analysis utility. |
| `mymodule/etabackend/` | `quantummicroscope/analysis/etabackend/` | Vendored ETA backend moved under analysis. |

## Legacy Reference Files

| Old path | New path | Notes |
| --- | --- | --- |
| `Microscope_GUI_ver2.py` | `quantummicroscope/legacy/Microscope_GUI_ver2.py` | Original Tkinter application reference. |
| `3Dheatmap.py` | `quantummicroscope/legacy/3Dheatmap.py` | Tk reference script. |
| `3Dheatmap2.py` | `quantummicroscope/legacy/3Dheatmap2.py` | Tk reference script. |
| `maintest.py` | `quantummicroscope/legacy/maintest.py` | Manual test script. |
| `correlarion_realtime.py` | `quantummicroscope/legacy/correlation_realtime.py` | Original typo fixed in file name. |
| `setup.py` | `quantummicroscope/legacy/setup_config_script.py` | JSON setup script; not packaging metadata. |
| `conda_sys.py` | `quantummicroscope/legacy/conda_sys.py` | Environment probe script. |
| `test_module.py` | `quantummicroscope/legacy/test_module.py` | Placeholder script. |
| `mymodule/test_module.py` | `quantummicroscope/legacy/mymodule_test_module.py` | Placeholder script. |
| `mymodule/__init__.py` | `quantummicroscope/legacy/mymodule_init.py` | Empty legacy package marker. |
