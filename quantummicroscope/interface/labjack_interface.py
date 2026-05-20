from __future__ import annotations

from typing import Protocol

from quantummicroscope.logic.models import ScanParameters


class LabJackInterface(Protocol):
    def open(self) -> None: ...

    def close(self) -> None: ...

    def move_to_pixel(self, x: int, y: int, params: ScanParameters) -> tuple[float, float]: ...

    def read_voltage(self) -> tuple[float, float]: ...
