from __future__ import annotations

from qtpy import QtCore

from quantummicroscope.analysis import g2_coordinates
from quantummicroscope.core.module import BaseModule


class G2Logic(BaseModule):
    sigLog = QtCore.Signal(str)

    def write_single_coordinate(self, x: int, y: int, timeresfile: str) -> None:
        g2_coordinates.write_single_coordinate(x=x, y=y, timeresfile=timeresfile)
        self.sigLog.emit(f"g2 coordinate ({x}, {y}) written")

    def clear_coordinate_file(self) -> None:
        g2_coordinates.clear_coord_file()
        self.sigLog.emit("g2 coordinate file cleared")
