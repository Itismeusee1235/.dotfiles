
#!/usr/bin/env bash

PIPE="/tmp/audio_wait.fifo"
mkfifo "$PIPE" 2>/dev/null

trap 'rm -f "$PIPE"; kill $(jobs -p) 2>/dev/null; exit 0' EXIT INT TERM

# Watch for battery events

LC_ALL=C pactl subscribe 2>/dev/null | grep --line-buffered -E "sink|server|client" > "$PIPE" &

# Failsafe timeout
(sleep 20 && echo "timeout" > "$PIPE") &

# Wait for event
read -r _ < "$PIPE"

