#!/usr/bin/env python

import os

# The Songs
os.system("mpc rescan")
os.system("mpc update")
SONGS = os.listdir("/home/muntazir/Music")
os.chdir("/home/muntazir/Music")
for i in SONGS:
    os.system(f'mpc --quiet add "{i}"')
