from __future__ import annotations

from pathlib import Path
from typing import Iterable

from quantummicroscope.core.module import BaseModule


class SaveLogic(BaseModule):
    def save_lines(self, path: str | Path, lines: Iterable[str]) -> None:
        target = Path(path)
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text("\n".join(lines), encoding="utf-8")
