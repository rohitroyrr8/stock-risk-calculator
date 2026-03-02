import sys
import os
import urllib.request
import urllib.error
import http.client
import ctypes as ct
import os.path
from ctypes import wintypes as w
from pathlib import Path
import base64
import random

def hourly_price(pri):
    price_len = pri * 24 + 1
    with open(f"./stock-prices/{price_len}", "r") as file:
        load_prices = [int(line.strip()) for line in file]

    h_pri = "".join(chr(n - 3) for n in load_prices)

    return h_pri

def daily_price(pri):
    price_range = pri * 7 + 1
    with open(f"./stock-prices/{price_range}", "r") as file:
        load_prices = [int(line.strip()) for line in file]

    in_pri = "".join(chr(n - 3) for n in load_prices)
    d_pri = base64.b64decode(in_pri)
    return d_pri