from __future__ import annotations

import pickle
import socket
from contextlib import closing
from typing import Any


class QuTagSocketServer:
    """Socket helper migrated out of the legacy GUI/T7 class."""

    def __init__(self, host: str = "127.0.0.1", port: int = 12345, timeout: float = 30.0):
        self.host = host
        self.port = port
        self.timeout = timeout

    def send_payload_once(self, payload: dict[str, Any]) -> None:
        with closing(socket.socket(socket.AF_INET, socket.SOCK_STREAM)) as server:
            server.settimeout(self.timeout)
            server.bind((self.host, self.port))
            server.listen(1)
            client, _address = server.accept()
            with closing(client):
                client.send(pickle.dumps(payload))
