
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

while true; do
    if [ -z "$waybar_pid" ] || ! kill -0 $waybar_pid 2>/dev/null; then
        waybar &
        waybar_pid=$!
    fi
    
    inotifywait -e modify ${CONFIG_FILES}
    
    killall waybar
    
    wait $waybar_pid 2>/dev/null
    
    waybar_pid=""
done

