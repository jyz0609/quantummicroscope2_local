from __future__ import annotations

import argparse
import logging
import sys

from qtpy import QtWidgets

from quantummicroscope.gui.main_window import QuantumMicroscopeMainWindow
from quantummicroscope.gui.style import apply_style


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Quantum Microscope Qudi-like Qt GUI")
    parser.add_argument(
        "--smoke",
        action="store_true",
        help="Construct the application and exit without showing the window.",
    )
    return parser


def main(argv: list[str] | None = None) -> int:
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(name)s: %(message)s")
    args = build_parser().parse_args(argv)
    app = QtWidgets.QApplication(sys.argv[:1])
    apply_style(app)
    window = QuantumMicroscopeMainWindow()
    if args.smoke:
        window.deleteLater()
        return 0
    window.show()
    return app.exec_()


if __name__ == "__main__":
    raise SystemExit(main())
