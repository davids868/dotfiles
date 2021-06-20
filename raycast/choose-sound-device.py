#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Change Sound Device
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Index", "optional": false }

# Optional parameters:
# @raycast.icon 🔊

import os, sys

stream = os.popen("SwitchAudioSource -a -t output")
devices = stream.read().split("\n")
devices = list(filter(None, devices))
index = sys.argv[1]
device_name = devices[int(index) - 1]

os.popen(f"SwitchAudioSource -s '{device_name}'")
