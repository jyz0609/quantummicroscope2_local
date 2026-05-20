from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, Protocol

import numpy as np

from quantummicroscope.logic.models import ScanParameters


@dataclass
class ScanCallbacks:
    image_ready: Callable[[np.ndarray], None] | None = None
    log: Callable[[str], None] | None = None
    cancel_requested: Callable[[], bool] | None = None


class ScannerInterface(Protocol):
    def configure_scan(self, params: ScanParameters) -> None: ...

    def start_scan(self, params: ScanParameters, callbacks: ScanCallbacks) -> np.ndarray: ...

    def stop_scan(self) -> None: ...

    def move_to_pixel(self, x: int, y: int, params: ScanParameters) -> tuple[float, float]: ...
