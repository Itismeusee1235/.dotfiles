#!/usr/bin/env python

import os
import sys

from PIL import Image

WALLPAPER_FOLDER = "/home/fenrir/Pictures/Wallpapers/"
DEFAULT_WAL = "/home/fenrir/Pictures/Wallpapers/CrazyGod.png"
WAL_COMMAND = 'wal -i "{}" --cols16 -n'
MAGIC_COMMAND = 'magick "{}" /home/fenrir/.cache/usr/wall.png'
COPY_COMMAND = 'magick "{}" "{}"'
SWWW_COMMAND = 'swww img "{}" --transition-fps 60 --transition-type any --transition-duration 1.5 --outputs eDP-1 && swww img "{}" --transition-fps 60 --transition-type any --transition-duration 1.5 --outputs HDMI-A-1'


def gif(file):
    im = Image.open(file)
    im.seek(0)
    im.convert("RGB").save("/home/fenrir/.cache/usr/wall-back.png")
    command = (
        WAL_COMMAND.format("/home/fenrir/.cache/usr/wall-back.png")
        + " && "
        + MAGIC_COMMAND.format("/home/fenrir/.cache/usr/wall-back.png")
        + " && "
        + SWWW_COMMAND.format(file, file)
    )
    # command = SWWW_COMMAND.format(file, file)
    print()
    print(command)
    print()
    os.system(command)

    os.system("rm -rf /home/fenrir/.cache/usr/wall-back.png")


def image(file):

    command = (
        WAL_COMMAND.format(file)
        + " && "
        + MAGIC_COMMAND.format(file)
        + " && "
        + SWWW_COMMAND.format(file, file)
    )

    ret = os.system(command)

    if ret != 0:
        print("BIG FAILURE SOMEWHERE")


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

    if file_path.split(".")[-1] == "gif":
        gif(file_path)
    else:
        image(file_path)

    file_name = os.path.basename(file_path)

    wall_path = WALLPAPER_FOLDER + file_name
    print(wall_path)
    if not os.path.isfile(wall_path):
        command = COPY_COMMAND.format(file_path, wall_path)
        ret = os.system(command)
        if ret != 0:
            print("Failed to copy")


main()
