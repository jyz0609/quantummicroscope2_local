# Quantum Microscope Code Architecture

This project is organized as a Qudi-like `qtpy` application without depending
on the Qudi runtime. The code is split by responsibility so both humans and AI
agents can quickly locate the right module before making changes.

## Quick Start

| Task | Command or file |
| --- | --- |
| Launch the Qt app | `python -m quantummicroscope.app` |
| Launch through compatibility entrypoint | `python qt_app.py` |
| Smoke-test app construction | `C:\Users\87691\anaconda3\envs\lidar0408ver2\python.exe -m quantummicroscope.app --smoke` |
| Qudi-like module wiring index | `quantummicroscope/config/module_config.yaml` |
| Old-file migration lookup | `quantummicroscope/legacy/MIGRATION_INDEX.md` |

`qt_app.py` is kept as a thin compatibility entrypoint. New application code
should live under `quantummicroscope/`.

## Layer Rules

| Layer | Responsibility | Must not do |
| --- | --- | --- |
| `gui/` | Qt widgets, layouts, user interaction, display updates, QSS styling | No Tkinter, LabJack, TimeTagger, sockets, or blocking hardware loops |
| `logic/` | Experiment workflows, state, parameters, Qt signals, workers, orchestration | No direct widget construction and no device-driver details in GUI callbacks |
| `hardware/` | Device adapters, dummy hardware, LabJack, TimeTagger, socket helpers | No `QtWidgets` and no GUI state access |
| `analysis/` | ETA analysis, image processing, peak finding, g2 coordinates, filename tools | No Qt GUI ownership; keep analysis callable from logic/workers |
| `interface/` | Protocols/contracts between logic and hardware/analysis | No implementation-specific side effects |
| `core/` | Small Qudi-like utilities such as module lifecycle and connectors | No experiment-specific behavior |

Long-running scans, TimeTagger acquisition, blocking DAQ reads, file analysis,
and calibration loops must run behind logic workers or other non-GUI execution
paths. Qt widgets should only be updated from GUI-thread slots receiving signals.

## Directory Map

| Path | Purpose |
| --- | --- |
| `quantummicroscope/app.py` | Main packaged application entrypoint. Builds `QApplication`, applies style, opens the main window. |
| `quantummicroscope/gui/` | Qudi-like Qt GUI layer. Main window, scanner GUI, dock widgets, and style live here. |
| `quantummicroscope/logic/` | State and workflow layer. Scanner, analysis, counter, g2, calibration, save logic, models, and workers live here. |
| `quantummicroscope/hardware/` | Hardware-facing adapters and dummy hardware. Split into `labjack/`, `scanner/`, `timetagger/`, and `network/`. |
| `quantummicroscope/interface/` | Protocols for scanner, counter, TimeTagger, LabJack, and analysis contracts. |
| `quantummicroscope/core/` | Qudi-like base infrastructure: `BaseModule`, `Connector`, and module state enum. |
| `quantummicroscope/analysis/` | Migrated analysis utilities and ETA backend code. |
| `quantummicroscope/config/` | JSON setup files and Qudi-like `module_config.yaml`. |
| `quantummicroscope/legacy/` | Original Tkinter/reference scripts and migration index. Use only for lookup or incremental porting. |

## Module Wiring

The current module wiring is documented in `quantummicroscope/config/module_config.yaml`.

| Module name | Class | Current connection |
| --- | --- | --- |
| `dummy_scanner` | `quantummicroscope.hardware.scanner.dummy_scanner_hardware.DummyScannerHardware` | Offline scan and count backend |
| `labjack_t7` | `quantummicroscope.hardware.labjack.labjack_t7.LabJackT7` | Real LabJack adapter; not the default scan backend |
| `dummy_timetagger` | `quantummicroscope.hardware.timetagger.dummy_timetagger.DummyTimeTagger` | Offline TimeTagger double |
| `scanner_logic` | `quantummicroscope.logic.scanner_logic.ScannerLogic` | Connects `scanner` and `counter` to `dummy_scanner` |
| `quantum_microscope_gui` | `quantummicroscope.gui.main_window.QuantumMicroscopeMainWindow` | Main GUI module |

`ScannerLogic` exposes Qudi-like connectors named `scanner` and `counter`. New
hardware should satisfy the relevant protocol in `interface/` before it is
connected into logic.

## Feature Locator

| Feature or question | Start here |
| --- | --- |
| App startup, CLI args, smoke mode | `quantummicroscope/app.py` |
| Compatibility launcher | `qt_app.py` |
| Main window, toolbar actions, dock setup | `quantummicroscope/gui/main_window.py` |
| Scanner GUI controls, form reading, image/count display | `quantummicroscope/gui/scanner_gui.py` |
| Qt stylesheet / visual theme | `quantummicroscope/gui/style.py` |
| Dock widget shells | `quantummicroscope/gui/widgets/` |
| Scan state, scan start/cancel, move-to-pixel, signal fanout | `quantummicroscope/logic/scanner_logic.py` |
| Worker object for threaded scans | `quantummicroscope/logic/workers.py` |
| Scan, analysis, g2, hardware config dataclasses | `quantummicroscope/logic/models.py` |
| Counter workflow placeholder | `quantummicroscope/logic/counter_logic.py` |
| Analysis workflow placeholder | `quantummicroscope/logic/analysis_logic.py` |
| g2 coordinate workflow | `quantummicroscope/logic/g2_logic.py` |
| Calibration workflow placeholder | `quantummicroscope/logic/calibration_logic.py` |
| Save helper workflow | `quantummicroscope/logic/save_logic.py` |
| Offline scan/count backend | `quantummicroscope/hardware/scanner/dummy_scanner_hardware.py` |
| Real scanner hardware integration target | `quantummicroscope/hardware/scanner/microscope_scanner_hardware.py` |
| LabJack T7 adapter | `quantummicroscope/hardware/labjack/labjack_t7.py` |
| Offline LabJack adapter | `quantummicroscope/hardware/labjack/dummy_labjack.py` |
| Swabian TimeTagger measurement adapter | `quantummicroscope/hardware/timetagger/swabian_timetagger.py` |
| Offline TimeTagger adapter | `quantummicroscope/hardware/timetagger/dummy_timetagger.py` |
| Swabian count-rate/filewriter legacy helpers | `quantummicroscope/hardware/timetagger/` |
| QuTAG/socket helper | `quantummicroscope/hardware/network/qutag_socket_server.py` |
| Scanner/counter/TimeTagger/LabJack protocols | `quantummicroscope/interface/` |
| Module lifecycle and connector utilities | `quantummicroscope/core/` |
| ETA analysis helpers | `quantummicroscope/analysis/eta_analysis.py` |
| Vendored ETA backend | `quantummicroscope/analysis/etabackend/` |
| Swabian scan-image analysis | `quantummicroscope/analysis/swabian_image_analysis.py` |
| Image processing / Gaussian / filters | `quantummicroscope/analysis/image_processing.py` |
| Peak analysis | `quantummicroscope/analysis/peak_analysis.py` |
| Filename parsing and g2 filename helpers | `quantummicroscope/analysis/filename_tools.py` |
| g2 coordinate file read/write | `quantummicroscope/analysis/g2_coordinates.py` |
| CNN classifier helper | `quantummicroscope/analysis/cnn_classifier.py` |
| Heatmap viewer script migrated from old code | `quantummicroscope/analysis/heatmap_viewer.py` |
| Original Tkinter GUI reference | `quantummicroscope/legacy/Microscope_GUI_ver2.py` |
| Old path to new path lookup | `quantummicroscope/legacy/MIGRATION_INDEX.md` |

## Common Change Recipes

| Goal | Where to change | Notes |
| --- | --- | --- |
| Add a new GUI control | `quantummicroscope/gui/scanner_gui.py` or a focused dock in `quantummicroscope/gui/widgets/` | GUI should call logic methods and receive logic signals. |
| Add a new scan parameter | `quantummicroscope/logic/models.py`, then read/write it in `ScannerGui` | Keep saved file formats unchanged unless explicitly requested. |
| Add a new hardware backend | Add implementation under `quantummicroscope/hardware/`, define or reuse a protocol in `quantummicroscope/interface/`, then connect it in logic/config. |
| Move a blocking operation out of GUI | Put the operation in a worker under `quantummicroscope/logic/workers.py` or a new logic worker module | Emit signals back to GUI; do not update widgets from the worker. |
| Replace dummy scan with real scan | Implement `ScannerInterface` behavior in `microscope_scanner_hardware.py` and wire it into `ScannerLogic` | Keep `DummyScannerHardware` available for smoke tests. |
| Add analysis from an old script | Move callable code to `quantummicroscope/analysis/`, call it from a logic method or worker | Do not make GUI import analysis scripts directly if the work can block. |
| Find original code after migration | Check `quantummicroscope/legacy/MIGRATION_INDEX.md` first | Then inspect `quantummicroscope/legacy/` for preserved references. |

## Legacy Code Lookup

The project was migrated from a root-level Tkinter-oriented layout. The primary
lookup table is `quantummicroscope/legacy/MIGRATION_INDEX.md`.

Use legacy code as reference only. New migrated GUI code should not import from
`quantummicroscope/legacy/`. When porting behavior from the old GUI:

1. Identify the old function/class in `MIGRATION_INDEX.md`.
2. Move device-specific code into `hardware/`.
3. Move workflow/state code into `logic/`.
4. Move pure analysis/file helpers into `analysis/`.
5. Connect GUI actions to logic methods with Qt signals/slots.

## Verification Commands

Run these checks after structural changes:

```powershell
rg -n "tkinter|ttk|ttkthemes|FigureCanvasTkAgg|NavigationToolbar2Tk|labjack|TimeTagger|socket" quantummicroscope\gui -g "*.py"
rg -n "QtWidgets" quantummicroscope\hardware -g "*.py"
C:\Users\87691\anaconda3\envs\lidar0408ver2\python.exe -m compileall -q quantummicroscope qt_app.py
C:\Users\87691\anaconda3\envs\lidar0408ver2\python.exe -m quantummicroscope.app --smoke
C:\Users\87691\anaconda3\envs\lidar0408ver2\python.exe qt_app.py --smoke
```

The first two `rg` commands should return no matches for newly migrated GUI and
hardware code. Legacy files may still contain Tkinter or direct hardware access.

## Notes for AI Agents

- Before editing, locate the feature in the Feature Locator table and inspect
  the relevant file. Do not guess based on old root-level names.
- New GUI code must not import Tkinter, LabJack, TimeTagger, socket, or blocking
  hardware modules.
- New hardware code must not import `QtWidgets` or create widgets.
- Long scans, continuous acquisition, file analysis, and calibration loops
  belong in logic workers or hardware adapters, not GUI slots.
- Prefer Qt signals from logic to GUI for status, logs, errors, images, and
  counts.
- Add or reuse an `interface/` protocol before adding new hardware capability.
- Keep `DummyScannerHardware`, `DummyLabJack`, and `DummyTimeTagger` useful for
  smoke tests and offline development.
- If a migrated function cannot be found, search `quantummicroscope/legacy/MIGRATION_INDEX.md`
  before scanning the full repository.
