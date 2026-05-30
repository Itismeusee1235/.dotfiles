#!/usr/bin/env bash

DIR="$HOME/.cache/wal"

inotifywait -e modify,create,move "$DIR" --format '%f' |
while read file; do
    if [[ "$file" == "colors.json" ]]; then
        exit 0
    fi
done
