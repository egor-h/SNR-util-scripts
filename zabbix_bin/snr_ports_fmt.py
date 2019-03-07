#!/usr/bin/env python3
from json import loads
from sys import stdin

raw = stdin.read()
o = loads(raw)

for i in o['ports']:
	if i['status'] is 1 and i['spd'] > 0:
		print("port {} is connected".format(i['port']))
