#!/usr/bin/env bash

PIPE="/tmp/brightness_wait.fifo"
mkfifo "$PIPE" 2> /dev/null

trap 'rm -f "$PIPE"; kill $(jobs -p) 2>/dev/null; exit 0' EXIT INT TERM

LC_ALL=C udevadm monitor --subsystem-match=backlight 2>/dev/null \
    | stdbuf -oL grep --line-buffered "change" > "$PIPE" &

read -r _ < "$PIPE"
