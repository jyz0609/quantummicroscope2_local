# Incremental Tkinter-to-Qt Migration Plan

## Summary
Migrate the current single-file Tkinter application in `Microscope_GUI_ver2.py` into a runnable Qt application using `qtpy`, `QtWidgets`, and `pyqtgraph`, while preserving existing scan, analysis, g2, calibration, and LabJack/Swabian behavior.

The current app mixes UI, scan orchestration, LabJack control, socket control, ETA analysis, plotting, logging, and blocking sleeps in one file. The migration should therefore start by wrapping existing behavior into separated layers before replacing every widget.

## Key Changes
- Create package structure:
  - `gui/`: Qt main window, scan tab widgets, controls, pyqtgraph image/count displays, log panel, QSS theme.
  - `logic/`: scan state, parameter models, filename generation, ETA analysis orchestration, calibration/g2 workflows, Qt signals.
  - `hardware/`: LabJack T7 adapter, Swabian/TimeTagger adapter, socket client/server helpers, dummy hardware.
- Keep `Microscope_GUI_ver2.py` as a legacy fallback during the first increments.
- Add a new Qt entrypoint, for example `qt_app.py`, and update `run_gui.bat` only after the Qt app can launch.
- Add `qtpy`, `PySide6`, and `pyqtgraph` to `requirements.txt`.

## Implementation Steps
1. **Bootstrap Qt Shell**
   - Add `gui/main_window.py`, `gui/scan_tab.py`, `gui/style.py`, and `qt_app.py`.
   - Build a Qudi-like main window with tabs, grouped controls, log pane, scan image area, counts panel, and start/cancel/analyze buttons.
   - Use `from qtpy import QtCore, QtGui, QtWidgets`.
   - Use `pyqtgraph.ImageView` or `GraphicsLayoutWidget` for scan images instead of Matplotlib/Tk widgets.

2. **Extract Shared State and Settings**
   - Add dataclasses in `logic/models.py` for scan parameters, analysis parameters, g2 parameters, and hardware config.
   - Load `microscope_table_setup.json` through logic/hardware config code.
   - Preserve defaults currently embedded in `ScanTab.init_parameters()`, including scan size, frequency, dwell time, amplitudes, lens slope, paths, recipes, modes, and g2 settings.

3. **Extract Hardware Layer**
   - Move the existing `T7` behavior into `hardware/labjack_t7.py` with no Qt widgets and no GUI references.
   - Replace GUI access like `self.gui.demo_mode.get()` with explicit parameter objects.
   - Emit progress through callbacks or logic signals, not direct widget/log writes.
   - Add `hardware/dummy_hardware.py` for offline mode so the Qt app can launch and exercise scan paths without LabJack/TimeTagger installed.

4. **Extract Logic Layer**
   - Add `logic/scanner_logic.py` as a `QtCore.QObject` with signals such as:
     - `sigStatusChanged(str)`
     - `sigLog(str)`
     - `sigError(str)`
     - `sigScanStarted()`
     - `sigScanFinished(str)`
     - `sigImageReady(object)`
     - `sigCountsReady(dict)`
   - Move scan start, cancel, analyze, filename suggestion, count extraction, calibration, move-to-pixel, and g2 workflow orchestration out of GUI callbacks.
   - Run blocking scan/analysis/g2 work through `QThread` worker objects.
   - Replace `time.sleep()` in GUI-triggered paths with worker sleeps or `QTimer` where applicable.

5. **Reconnect GUI to Logic**
   - GUI reads form values into parameter dataclasses and calls logic methods.
   - Logic emits signals back to the GUI for logs, errors, status, button enable/disable state, counts, and images.
   - GUI never calls `ljm`, `socket`, `TimeTagger`, ETA backend, or long-running file analysis directly.

6. **Modernize UI Carefully**
   - Apply a lightweight dark/neutral QSS theme with readable fields, clear disabled states, and danger styling for Cancel/Stop.
   - Use grouped panels for Acquisition, Analysis, Motion, g2/Calibration, Counts, Log, and Display.
   - Preserve existing controls and labels first; improve layout without changing saved file formats or workflow semantics.
   - Replace the Matplotlib embedded scan image with persistent pyqtgraph items updated via `setImage()`.

## Test Plan
- Launch legacy app remains possible until the Qt app is proven.
- Launch new Qt app in offline/dummy mode.
- Verify all existing default values appear in the Qt controls.
- Verify Start/Cancel/Analyze buttons trigger logic methods and update logs without freezing the UI.
- Verify dummy scan produces an image in pyqtgraph and enables zoom/selection behavior.
- Verify ETA analysis can still read the existing sample `Data/...timeres` path when dependencies are available.
- Verify LabJack safety checks still reject out-of-range voltages.
- Verify g2 coordinate file actions still write/clear coordinates.
- Verify no new migrated GUI files import `tkinter`, `ttk`, `ThemedTk`, `FigureCanvasTkAgg`, or `NavigationToolbar2Tk`.

## Assumptions
- The first implementation increment should prioritize a working Qt shell plus offline/dummy workflow before full hardware execution.
- Existing data formats, filenames, recipes, and analysis output paths must remain unchanged.
- Hardware-specific behavior should be preserved by moving code, not rewriting scan algorithms from scratch.
- `Microscope_GUI_ver2.py` should not be deleted during early migration; it remains the reference and fallback.
