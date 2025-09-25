#!/bin/bash

# Check if swww-daemon is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo "swww-daemon is not running. Starting it now..."
    swww-daemon &
else
    echo "swww-daemon is already running."
fi

# Find all image files in .dist/ folder with specified MIME types
image_files=$(find ./dist/ -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.svg" \))

# Check if any image files are found
if [ -z "$image_files" ]; then
    echo "No image files found in .dist/ directory."
    exit 1
fi

# Pick one randomly and pipe it into swww img
random_image=$(echo "$image_files" | shuf -n 1)
echo "Setting wallpaper to: $random_image"
swww img "$random_image"

