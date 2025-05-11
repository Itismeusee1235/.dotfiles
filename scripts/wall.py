#!/usr/bin/env python

import os
import sys

WALLPAPER_FOLDER = "/home/fenrir/Pictures/Wallpapers/"
DEFAULT_WAL = "/home/fenrir/Pictures/Wallpapers/CrazyGod.png"
WAL_COMMAND = 'wal -i "{}" --cols16 -n'
MAGIC_COMMAND = 'magick "{}" /home/fenrir/.cache/usr/wall.png'
SWWW_COMMAND = 'swww img "{}" --transition-fps 60 --transition-type any --transition-duration 1.5 --outputs eDP-1 && swww img "{}" --transition-fps 60 --transition-type any --transition-duration 1.5 --outputs HDMI-A-1'


def main():
    wall = sys.argv[1]
    print(f"Input: {wall}")
    print(f"Exists? {os.path.isfile(wall)}")
    cwd = os.getcwd()
    file_path = ""

    if os.path.isfile(wall):
        file_path = wall
    elif os.path.isfile(os.path.join(cwd, wall)):
        file_path = os.path.join(cwd, wall)
    elif os.path.isfile(os.path.join(WALLPAPER_FOLDER, wall)):
        file_path = os.path.join(WALLPAPER_FOLDER, wall)
    else:
        print("Invalid file .. switching to default")
        file_path = DEFAULT_WAL

    command = (
        WAL_COMMAND.format(file_path)
        + " && "
        + MAGIC_COMMAND.format(file_path)
        + " && "
        + SWWW_COMMAND.format(file_path, file_path)
    )

    ret = os.system(command)

    if ret != 0:
        print("BIG FAILURE SOMEWHERE")


main()
