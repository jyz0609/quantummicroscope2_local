from __future__ import annotations

from typing import Protocol


class CounterInterface(Protocol):
    def read_counts(self) -> dict[int, int]: ...
