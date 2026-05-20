from __future__ import annotations

import math
import time
from typing import Callable

import numpy as np

from quantummicroscope.logic.models import ScanParameters


ProgressCallback = Callable[[str], None]
ImageCallback = Callable[[np.ndarray], None]
CancelCallback = Callable[[], bool]


class DummyScannerHardware:
    """Offline scanner/counter backend used while hardware modules are offline."""

    def configure_scan(self, params: ScanParameters) -> None:
        self._progress(
            f"Configured dummy scan: {params.dim_x} x {params.dim_y}, dwell {params.int_time:g} s"
        )

    def start_scan(self, params: ScanParameters, callbacks) -> np.ndarray:
        return self.run_scan(
            params,
            image_callback=getattr(callbacks, "image_ready", None),
            cancel_requested=getattr(callbacks, "cancel_requested", None),
        )

    def stop_scan(self) -> None:
        self._progress("Dummy scanner stop requested")

    def __init__(self, progress: ProgressCallback | None = None):
        self._progress = progress or (lambda _message: None)
        self._x_pixel = 1
        self._y_pixel = 1

    def run_scan(
        self,
        params: ScanParameters,
        image_callback: ImageCallback | None = None,
        cancel_requested: CancelCallback | None = None,
    ) -> np.ndarray:
        cancel_requested = cancel_requested or (lambda: False)
        size = max(4, int(params.dim_y))
        image = np.zeros((size, size), dtype=float)
        x_axis = np.linspace(-1.0, 1.0, size)
        y_axis = np.linspace(-1.0, 1.0, size)
        xx, yy = np.meshgrid(x_axis, y_axis)

        self._progress("Dummy scan started")
        for row in range(size):
            if cancel_requested():
                self._progress("Dummy scan cancelled")
                break
            center_x = math.sin(row / max(size - 1, 1) * math.pi) * 0.35
            center_y = math.cos(row / max(size - 1, 1) * math.pi) * 0.25
            gaussian = np.exp(-((xx - center_x) ** 2 + (yy - center_y) ** 2) * 8.0)
            ripple = 0.08 * np.sin((xx + row / size) * math.pi * 8.0)
            image[row, :] = gaussian[row, :] + ripple[row, :] + row / size * 0.15
            if image_callback and (row % max(1, size // 20) == 0 or row == size - 1):
                image_callback(image.copy())
            time.sleep(min(max(params.int_time, 0.001), 0.03))

        self._progress("Dummy scan finished")
        return image

    def move_to_pixel(self, x: int, y: int, params: ScanParameters) -> tuple[float, float]:
        size = max(1, int(params.dim_y) - 1)
        if not 0 <= x <= size or not 0 <= y <= size:
            raise ValueError(f"Pixel ({x}, {y}) is outside scan range 0..{size}")
        x_voltage = params.min_x + (params.max_x - params.min_x) * x / size
        y_voltage = params.min_y + (params.max_y - params.min_y) * y / size
        self._x_pixel = x
        self._y_pixel = y
        self._progress(f"Dummy move to pixel ({x}, {y}) -> ({x_voltage:.4f} V, {y_voltage:.4f} V)")
        return x_voltage, y_voltage

    def read_counts(self) -> dict[int, int]:
        base = 1200 + self._x_pixel * 17 + self._y_pixel * 11
        return {channel: base + channel * 143 for channel in range(1, 5)}
