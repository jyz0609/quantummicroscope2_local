from __future__ import annotations

from typing import Any


class Connector:
    """Minimal Qudi-like connector descriptor.

    A module declares ``scanner = Connector(interface="ScannerInterface")`` and
    receives the concrete target through ``connect_modules(scanner=hardware)``.
    Calling ``self.scanner()`` returns the connected object.
    """

    def __init__(self, interface: str):
        self.interface = interface
        self.name = ""
        self.storage_name = ""

    def __set_name__(self, owner: type, name: str) -> None:
        self.name = name
        self.storage_name = f"_{name}_connector_target"

    def __get__(self, instance: Any, owner: type | None = None):
        if instance is None:
            return self

        def _resolve():
            try:
                return getattr(instance, self.storage_name)
            except AttributeError as exc:
                raise RuntimeError(
                    f"Connector '{self.name}' for interface '{self.interface}' is not connected."
                ) from exc

        return _resolve

    def connect(self, instance: Any, target: Any) -> None:
        setattr(instance, self.storage_name, target)
