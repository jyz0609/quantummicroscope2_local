from __future__ import annotations

from enum import Enum


class ModuleState(str, Enum):
    DEACTIVATED = "deactivated"
    IDLE = "idle"
    RUNNING = "running"
    ERROR = "error"
