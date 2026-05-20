from __future__ import annotations

from quantummicroscope.logic.models import G2Parameters


class DummyTimeTagger:
    """Offline TimeTagger adapter used by logic smoke tests."""

    def __init__(self):
        self.file_path = ""
        self.dumping = False

    def start_dump(self, file_path: str) -> None:
        self.file_path = file_path
        self.dumping = True

    def stop_dump(self) -> None:
        self.dumping = False

    def run_g2_measurement(self, params: G2Parameters) -> str:
        return f"dummy_g2_{params.measuring_time}s.timeres"
