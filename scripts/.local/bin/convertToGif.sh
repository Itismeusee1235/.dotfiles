#!/bin/bash

input="$1"
echo "$input"
output="${input%.mp4}.gif"
echo "$output"

mkdir -p frames
ffmpeg -i "$input" -vf "fps=15, scale=1902:1080:flags=lanczos" "frames/frame%04d.png"
echo "================Made into frames ==============="
ls frames
gifski --fps 15 --output "$output" frames/frame*.png
rm -rf frames
