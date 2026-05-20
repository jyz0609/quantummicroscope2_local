from __future__ import annotations

from quantummicroscope.hardware.labjack.labjack_t7 import LabJackT7
from quantummicroscope.logic.models import ScanParameters


class MicroscopeScannerHardware:
    """Hardware-facing scanner adapter.

    This class is the migration target for the scan-related parts of the legacy
    ``T7`` class. The current increment delegates safe pixel moves to LabJack
    and keeps full waveform streaming for a later worker-backed migration.
    """

    def __init__(self, labjack: LabJackT7):
        self.labjack = labjack
        self.scan_params: ScanParameters | None = None

    def configure_scan(self, params: ScanParameters) -> None:
        self.scan_params = params

    def start_scan(self, params: ScanParameters, callbacks):
        raise NotImplementedError(
            "Real LabJack streaming scan is not migrated yet. Use DummyScannerHardware offline."
        )

    def stop_scan(self) -> None:
        self.labjack.close()

    def move_to_pixel(self, x: int, y: int, params: ScanParameters) -> tuple[float, float]:
        return self.labjack.move_to_pixel(x, y, params)

    def read_counts(self) -> dict[int, int]:
        raise NotImplementedError("Counts are provided by a counter/timetagger module.")
