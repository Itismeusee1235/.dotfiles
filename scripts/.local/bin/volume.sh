#!/bin/bash

# Usage: ./volume-popup.sh [+/-PERCENT | m]

MAX_VOLUME=150  # max volume in percent
arg="$1"

if [ -z "$arg" ]; then
    echo "Usage: $0 [+/-PERCENT | m]"
    exit 1
fi

# Handle mute toggle
if [[ "$arg" == "m" || "$arg" == "M" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    sleep 0.1
else
    # Apply volume change
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$arg"
    sleep 0.1

    # Check new volume
    info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    volume_raw=$(echo "$info" | cut -d ' ' -f2)

    # Extract integer and decimal parts
    int_part=${volume_raw%.*}
    dec_part=${volume_raw#*.}
    dec_part=${dec_part:0:2}

    if [ ${#dec_part} -eq 1 ]; then
        dec_part="${dec_part}0"
    elif [ -z "$dec_part" ]; then
        dec_part="00"
    fi

    # Compute current volume in percent
    volume_percent=$(( int_part * 100 + 10#$dec_part ))

    # If over max, reset to max
    if [ "$volume_percent" -gt "$MAX_VOLUME" ]; then
        # Convert back to float (e.g., 150 -> 1.5)
        max_volume_float="1.$((MAX_VOLUME - 100))"
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$max_volume_float"
        volume_percent=$MAX_VOLUME
        sleep 0.1
    fi
fi

# Re-fetch info (after applying volume or mute)
info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume_raw=$(echo "$info" | cut -d ' ' -f2)
int_part=${volume_raw%.*}
dec_part=${volume_raw#*.}
dec_part=${dec_part:0:2}

if [ ${#dec_part} -eq 1 ]; then
    dec_part="${dec_part}0"
elif [ -z "$dec_part" ]; then
    dec_part="00"
fi

volume_percent=$(( int_part * 100 + 10#$dec_part ))

# Show notification
if [[ "$info" == *"[MUTED]"* ]]; then
    notify-send -t 1000 -r 9993 "🔇 Volume muted"
else
    notify-send -t 1000 -r 9993 "🔊 Volume: ${volume_percent}%"
fi
