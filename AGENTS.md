# AGENTS.md

## Project goal

Migrate the existing Tkinter GUI to a Qudi-like Qt GUI.

The new GUI should be modern, clean, responsive, and suitable for laboratory instrument control.

## Required stack

Use:

```python
from qtpy import QtCore, QtGui, QtWidgets
```

Preferred packages:

```bash
pip install PySide6 qtpy pyqtgraph numpy
```

Use `pyqtgraph` for live plots, images, histograms, and scan displays.

Do not use Tkinter in newly migrated GUI code.

## Architecture

Separate the application into three layers:

```text
gui/       Qt widgets, layouts, user interaction, display updates
logic/     experiment workflow, state, data handling, signals
hardware/  device-specific code or dummy hardware
```

GUI code must not directly contain DAQ, TimeTagger, serial, socket, or long-running hardware loops.

Hardware code must not create Qt widgets.

## Communication pattern

Use Qt signals and slots between layers.

Example:

```python
class ScannerLogic(QtCore.QObject):
    sigStatusChanged = QtCore.Signal(str)
    sigNewImage = QtCore.Signal(object)
    sigError = QtCore.Signal(str)
```

GUI buttons should call logic methods. Logic should emit signals back to the GUI.

## Threading and responsiveness

Never run long scans, blocking DAQ reads, file analysis, or continuous acquisition in the GUI thread.

Use `QTimer` for lightweight periodic updates.

Use `QThread` or a worker object for blocking or long-running work.

Do not update Qt widgets directly from a background thread. Emit signals to the GUI instead.

## GUI style

While migrating, make the interface visually modern but lightweight.

Use Qt Style Sheets/QSS for basic styling:

- dark or neutral theme
- clean spacing
- readable fonts
- modern buttons and input boxes
- clear disabled states
- clear Stop / Emergency Stop danger buttons
- no heavy animations or visual effects

The GUI should look like scientific instrument-control software, not a flashy consumer app.

## Plotting

Use `pyqtgraph` for real-time display.

Do not recreate plot widgets during updates.

Prefer updating existing items:

```python
self.curve.setData(x, y)
self.image_view.setImage(image)
```

## Logging and errors

Replace `print()` used for user feedback with GUI logging and Python `logging`.

Show user-visible logs in a `QPlainTextEdit` or similar widget.

Catch errors in logic or worker code and emit `sigError(str)`.

The GUI should show errors clearly and return to a safe state.

## Migration strategy

Do the migration incrementally:

1. Preserve existing behavior.
2. Extract non-GUI logic from Tkinter callbacks.
3. Create a minimal `qtpy` Qt main window.
4. Rebuild the old controls using QtWidgets.
5. Connect GUI actions to logic methods.
6. Add modern lightweight QSS styling.
7. Replace live Matplotlib/Tkinter drawing with `pyqtgraph` where useful.
8. Move blocking work out of the GUI thread.
9. Add dummy hardware if real hardware is needed for testing.

Keep the project runnable after each major step.

## Do not

- Do not make one giant `MainWindow` containing GUI, hardware, and analysis code.
- Do not remove existing functionality unless explicitly requested.
- Do not silently change saved data formats.
- Do not block the GUI thread.
- Do not update widgets from worker threads.
- Do not add unnecessary dependencies for visual effects.

## Acceptance criteria

The migrated app should:

- launch successfully
- use `qtpy` and QtWidgets
- preserve the original GUI functions
- have separated GUI, logic, and hardware layers
- remain responsive during long operations
- use `pyqtgraph` for real-time plots/images when needed
- show logs and errors clearly
- have a cleaner, more modern appearance than the original Tkinter GUI

