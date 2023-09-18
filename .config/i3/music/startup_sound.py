#!/usr/bin/env python

import os
import random
DIR="/home/muntazir/Music/startup_sounds"
Musics=[music for music in os.listdir(DIR)]

CHOSEN=random.choice(Musics)
os.system(f"mpv --no-video '{DIR}/{CHOSEN}'")
