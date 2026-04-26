#!/usr/bin/env bash

PIPE="/tmp/battery_wait.fifo"
mkfifo "$PIPE" 2>/dev/null

trap 'rm -f "$PIPE"; kill $(jobs -p) 2>/dev/null; exit 0' EXIT INT TERM

# Watch for battery events
LC_ALL=C udevadm monitor --subsystem-match=power_supply 2>/dev/null \
    | stdbuf -oL grep --line-buffered "change" > "$PIPE" &

# Failsafe timeout
(sleep 30 && echo "timeout" > "$PIPE") &

# Wait for event
read -r _ < "$PIPE"

