from __future__ import annotations

from typing import Protocol

import numpy as np

from quantummicroscope.logic.models import AnalysisParameters


class AnalysisInterface(Protocol):
    def analyze_file(self, params: AnalysisParameters) -> np.ndarray: ...
