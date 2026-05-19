from __future__ import annotations

from dataclasses import dataclass

from logic.models import HardwareConfig, ScanParameters


try:
    from labjack import ljm
except Exception:  # pragma: no cover - depends on laboratory driver install.
    ljm = None


@dataclass
class VoltageLimits:
    x_min: float = 0.0
    x_max: float = 4.0
    y_abs_max: float = 4.0


class LabJackT7Hardware:
    """Qt-independent LabJack adapter.

    This is the migration target for the legacy ``T7`` class. The first
    increment exposes safe connection and move/read primitives without creating
    widgets or depending on GUI state.
    """

    x_address = "TDAC3"
    y_address = "TDAC2"
    x_address_read = "AIN2"
    y_address_read = "AIN0"

    def __init__(self, config: HardwareConfig, limits: VoltageLimits | None = None):
        self.config = config
        self.limits = limits or VoltageLimits()
        self.handle = None

    @property
    def available(self) -> bool:
        return ljm is not None

    def open(self) -> None:
        if ljm is None:
            raise RuntimeError("LabJack LJM driver is not available in this environment.")
        if self.handle is None:
            self.handle = ljm.openS("T7", "ANY", "ANY")

    def close(self) -> None:
        if ljm is not None and self.handle is not None:
            ljm.close(self.handle)
        self.handle = None

    def validate_pixel_move(self, x_voltage: float, y_voltage: float) -> None:
        if not self.limits.x_min <= x_voltage <= self.limits.x_max:
            raise ValueError(f"Unsafe X voltage {x_voltage:.4f} V")
        if abs(y_voltage) > self.limits.y_abs_max:
            raise ValueError(f"Unsafe Y voltage {y_voltage:.4f} V")

    def pixel_to_voltage(self, x: int, y: int, params: ScanParameters) -> tuple[float, float]:
        size = max(1, int(params.dim_y) - 1)
        if not 0 <= x <= size or not 0 <= y <= size:
            raise ValueError(f"Pixel ({x}, {y}) is outside scan range 0..{size}")
        x_voltage = params.min_x + (params.max_x - params.min_x) * x / size
        y_voltage = params.min_y + (params.max_y - params.min_y) * y / size
        self.validate_pixel_move(x_voltage, y_voltage)
        return x_voltage, y_voltage

    def move_to_pixel(self, x: int, y: int, params: ScanParameters) -> tuple[float, float]:
        x_voltage, y_voltage = self.pixel_to_voltage(x, y, params)
        self.open()
        ljm.eWriteNames(self.handle, 2, [self.x_address, self.y_address], [x_voltage, y_voltage])
        return x_voltage, y_voltage

    def read_voltage(self) -> tuple[float, float]:
        self.open()
        return tuple(ljm.eReadNames(self.handle, 2, [self.x_address_read, self.y_address_read]))
