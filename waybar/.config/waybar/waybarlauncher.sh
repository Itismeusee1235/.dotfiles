
CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css $HOME/.cache/wal/colors-waybar.css $HOME/.cache/usr/wall.png"



killall waybar

waybar_visible=true
waybar_pid=""

toggle_waybar() {
    if $waybar_visible; then
        killall -SIGUSR1 waybar
        waybar_visible=false
    else
        killall -SIGUSR1 waybar
        waybar_visible=true
    fi
}

trap toggle_waybar SIGUSR1

