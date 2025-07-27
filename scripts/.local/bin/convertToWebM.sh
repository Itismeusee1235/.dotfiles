
#!/bin/bash

input="$1"
echo "Input: $input"

# Extract base filename (without extension)
filename=$(basename -- "$input")
basename="${filename%.*}"

# Output paths
output_dir="./mp4"
output_path="$output_dir/${basename}.webm"

# Create output directory
mkdir -p "$output_dir"

# Convert to 1080p WebM
ffmpeg -i "$input" -vf "scale=1920:1080:flags=lanczos" -c:v libvpx-vp9 -crf 15 -b:v 1M "$output_path"

echo "✅ Saved: $output_path"
