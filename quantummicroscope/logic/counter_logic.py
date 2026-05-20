from __future__ import annotations

from qtpy import QtCore

from quantummicroscope.core.module import BaseModule


class CounterLogic(BaseModule):
    sigCountsUpdated = QtCore.Signal(object)

    def __init__(self, counter=None, config=None, parent=None):
        super().__init__(config=config, parent=parent)
        self.counter = counter

    @QtCore.Slot()
    def update_counts(self):
        if self.counter is None:
            return {}
        counts = self.counter.read_counts()
        self.sigCountsUpdated.emit(counts)
        return counts
