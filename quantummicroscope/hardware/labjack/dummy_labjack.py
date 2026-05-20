from __future__ import annotations

from quantummicroscope.logic.models import ScanParameters


class DummyLabJack:
    """Offline LabJack-compatible adapter for tests and UI smoke runs."""

    def __init__(self):
        self.x_voltage = 0.0
        self.y_voltage = 0.0

    def open(self) -> None:
        return None

    def close(self) -> None:
        return None

    def move_to_pixel(self, x: int, y: int, params: ScanParameters) -> tuple[float, float]:
        size = max(1, int(params.dim_y) - 1)
        self.x_voltage = params.min_x + (params.max_x - params.min_x) * x / size
        self.y_voltage = params.min_y + (params.max_y - params.min_y) * y / size
        return self.x_voltage, self.y_voltage

    def read_voltage(self) -> tuple[float, float]:
        return self.x_voltage, self.y_voltage
