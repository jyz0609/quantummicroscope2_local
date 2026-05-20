from __future__ import annotations

import logging
from typing import Any

from qtpy import QtCore


class BaseModule(QtCore.QObject):
    """Small Qudi-like module base with activation hooks."""

    sigStateChanged = QtCore.Signal(str)

    def __init__(self, config: dict[str, Any] | None = None, parent=None):
        super().__init__(parent)
        self.config = config or {}
        self.log = logging.getLogger(f"{self.__class__.__module__}.{self.__class__.__name__}")
        self.module_state = "deactivated"

    def on_activate(self) -> None:
        self.module_state = "active"
        self.sigStateChanged.emit(self.module_state)

    def on_deactivate(self) -> None:
        self.module_state = "deactivated"
        self.sigStateChanged.emit(self.module_state)
