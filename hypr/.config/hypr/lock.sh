case "$1" in
"1")
  cp ~/.cache/usr/wall.png ~/.cache/usr/lockscreen.png
  ;;
"2")
  grim ~/.cache/usr/lockscreen.png
  ;;
esac
hyprlock
