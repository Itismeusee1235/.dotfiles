#!/usr/bin/env python


import os
import sys

from PIL import Image

WALLPAPER_FOLDER = "/home/fenrir/Pictures/Wallpapers/"
DEFAULT_WAL = "/home/fenrir/Pictures/Wallpapers/CrazyGod.png"

CLEAR_CACHE_COMMAND = "rm -f /home/fenrir/.cache/wal/tmp/*"
MATUGEN_COMMAND = "matugen image {} --mode dark --source-color-index 0 --old-json-output --json hex > ~/.cache/wal/colors.json"
PYWAL_COMMAND = "wal -i {} --cols16 darken"
MAGIC_COMMAND = 'magick "{}" /home/fenrir/.cache/usr/wall.png'
COPY_COMMAND = 'magick "{}" "{}"'
SWWW_COMMAND = (
    'awww img "{}" --transition-fps 60 --transition-type any --transition-duration 1.5'
)
QUICKSHELL_RELOAD = "qs ipc call TopBar forceReload"
HYPRLAND_RELOAD = "hyprctl reload"

WALLPAPER = "/home/fenrir/.cache/usr/wall.png"


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

    # Copy BG to cache
    file_name = os.path.basename(file_path)
    os.system(MAGIC_COMMAND.format(file_path, WALLPAPER))
    print(file_path, file_name, WALLPAPER)

    matu = os.system(MATUGEN_COMMAND.format(WALLPAPER))
    pywal = os.system(PYWAL_COMMAND.format(WALLPAPER))
    test = os.system("mv ~/.cache/wal/tmp/* ~/.cache/wal/")
    hypr = os.system(HYPRLAND_RELOAD)
    qs = os.system(QUICKSHELL_RELOAD)
    sww = os.system(SWWW_COMMAND.format(WALLPAPER))
    os.system(CLEAR_CACHE_COMMAND)
    print(pywal, "\n")
    print(hypr, "\n")
    print(qs, "\n")
    print(sww, "\n")

    wall_path = WALLPAPER_FOLDER + file_name

    if not os.path.isfile(wall_path):
        command = COPY_COMMAND.format(file_path, wall_path)
        ret = os.system(command)
        if ret != 0:
            print("Failed to copy")


main()
