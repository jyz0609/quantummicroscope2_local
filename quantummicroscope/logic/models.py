from __future__ import annotations

from dataclasses import dataclass
from datetime import date, datetime
import json
from pathlib import Path


PACKAGE_ROOT = Path(__file__).resolve().parents[1]
PROJECT_ROOT = PACKAGE_ROOT.parent
CONFIG_ROOT = PACKAGE_ROOT / "config"


@dataclass(frozen=True)
class HardwareConfig:
    x_offset: float = 0.0
    y_offset: float = 0.0
    calibrated_lenslope: float = 313.0
    host: str = "127.0.0.1"

    @classmethod
    def load(cls, path: Path | None = None) -> "HardwareConfig":
        config_path = path or CONFIG_ROOT / "microscope_table_setup.json"
        if not config_path.exists():
            return cls()
        with config_path.open("r", encoding="utf-8") as handle:
            data = json.load(handle)
        return cls(
            x_offset=float(data.get("x_offset", 0.0)),
            y_offset=float(data.get("y_offset", 0.0)),
            calibrated_lenslope=float(data.get("calibrated_lenslope", 313.0)),
            host=str(data.get("host", "127.0.0.1")),
        )


@dataclass
class ScanParameters:
    clue: str = "test"
    data_folder: str = f"K:/Microscope/Data/{date.today().strftime('%y%m%d')}"
    data_file: str = ""
    speed_mode: str = "slow"
    sweep_mode: str = "linear"
    dim_y: int = 100
    int_time: float = 0.005
    freq: float = 1.0
    nr_frames: int = 1
    amp_x: float = 0.31949
    amp_y: float = 0.31949
    min_x: float = 0.0
    max_x: float = 0.0
    min_y: float = 0.0
    max_y: float = 0.0
    scope_length: float = 100.0
    lens_slope: float = 313.0
    step_size_nm: float = 30.0
    record_scan: bool = True
    diagnostics_mode: bool = False
    offline_mode: bool = True

    @classmethod
    def defaults(cls, config: HardwareConfig | None = None) -> "ScanParameters":
        cfg = config or HardwareConfig.load()
        params = cls(lens_slope=cfg.calibrated_lenslope)
        params.scope_length = round(params.amp_x * params.lens_slope, 2)
        params.step_size_nm = round(params.scope_length * 1000 / params.dim_y, 2)
        params.min_x = round(-params.amp_x + cfg.x_offset, 10)
        params.max_x = round(params.amp_x + cfg.x_offset, 10)
        params.min_y = round(-params.amp_y + cfg.y_offset, 10)
        params.max_y = round(params.amp_y + cfg.y_offset, 10)
        return params

    @property
    def dim_x(self) -> int:
        return self.dim_y

    @property
    def scan_time_seconds(self) -> float:
        return float(self.dim_y * self.dim_y * self.int_time * max(self.nr_frames, 1))

    def suggested_filename(self) -> str:
        now = datetime.now()
        return (
            f"{self.clue}_scantime({round(self.scan_time_seconds, 3)})"
            f"_dwellTime({self.int_time})"
            f"_sineAmp({self.amp_x})"
            f"_stepAmp({self.amp_y})"
            f"_stepDim({self.dim_y})"
            f"_date({now:%y%m%d})_time({now:%Hh%Mm%Ss}).timeres"
        )


@dataclass
class AnalysisParameters:
    data_file: str = (
        "Data/240918/hBN1000_scantime(100.0)_dwellTime(0.01)_sineAmp(0.2)"
        "_stepAmp(0.2)_stepDim(100)_date(240918)_time(15h14m56s).timeres"
    )
    eta_recipe: str = "Swabian_multiframe_recipe_bidirectional_segments_marker4_28.eta"
    eta_recipe_slow: str = "Swabian_slow_multiframe_recipe_bidirectional_segments_marker4_28.eta"
    eta_recipe_fast: str = "Swabian_multiframe_recipe_bidirectional_segments_marker4_28.eta"
    save_folder: str = "/Analysis"
    bins: int = 20000
    channel_selection: str = "h2"


@dataclass
class G2Parameters:
    measuring_time: int = 60
    calibration_interval_time: int = 30
    do_calibration: bool = False
    find_peak_number: int = 10
    enable_multi_peak_measurement: bool = False
    average_count_per_bin: int = 3
