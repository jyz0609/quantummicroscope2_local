from __future__ import annotations

from typing import Protocol

from quantummicroscope.logic.models import G2Parameters


class TimeTaggerInterface(Protocol):
    def start_dump(self, file_path: str) -> None: ...

    def stop_dump(self) -> None: ...

    def run_g2_measurement(self, params: G2Parameters) -> str: ...
