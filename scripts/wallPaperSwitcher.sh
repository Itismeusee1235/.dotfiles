#!/bin/bash
source ~/.bashrc
wallsDirectory=$HOME/Pictures/Wallpapers/

selected_wallpaper=$(for a in "$wallsDirectory"/*; do
  echo -en "${a##*/}\0icon\x1fthumbnail://$a\n"
done | rofi -dmenu -show-icons -config ~/.config/rofi/wallpaper-config.rasi)

if [ -n "$selected_wallpaper" ]; then
  full_path=$wallsDirectory$selected_wallpaper
  # echo "$full_path"
  /home/fenrir/.local/bin/wall.py "$full_path"
fi

