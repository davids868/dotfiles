#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sound Devices
# @raycast.mode inline
# @raycast.refreshTime 100m

# Optional parameters:
# @raycast.icon 🔊

import os

colors = {
    "green": "\033[92m",
    "yellow": "\033[93m",
    "red": "\033[91m",
    "grey": "\033[90m",
    "white": "\033[97m",
    "end": "\033[0m",
}


def color(color, message):
    return f"{color}{message}{colors['end']}"


stream = os.popen("SwitchAudioSource -a -t output")
devices = stream.read().split("\n")
devices = list(filter(None, devices))

stream = os.popen("SwitchAudioSource -c -t output")
current = devices.index(stream.read().strip())


for i, v in enumerate(devices):
    name = f"{i + 1} - {v.split(' ')[0]}"
    name = color(colors["green" if i == current else "yellow"], name)
    devices[i] = name

devices = " ┋ ".join(devices)
print(devices)
