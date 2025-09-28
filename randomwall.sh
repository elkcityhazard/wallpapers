#!/usr/bin/env bash

# Set the Wayland display environment variable (should match your session)

# Check if swww-daemon is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo "swww-daemon is not running. Starting it now..."
    swww-daemon &
    sleep 5  # Give it some time to start
else
    echo "swww-daemon is already running."
fi

# Find all image files in the specified folder
image_files=$(find /home/andrew/wallpapers/dist/ -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.svg" \))

# Check if any image files are found
if [ -z "$image_files" ]; then
    echo "No image files found in /home/andrew/wallpapers/dist/ directory."
    exit 1
fi

shouldChange=true

while [[ "${shouldChange}" ]]; do
  sleep 180s
# Pick one randomly and pipe it into swww img
random_image=$(echo "$image_files" | shuf -n 1)
echo "Setting wallpaper to: $random_image"
swww img "$random_image" -t wave
done



