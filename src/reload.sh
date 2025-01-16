#!/bin/bash

# Class name to search for
CLASS_NAME="Chromium"
export DISPLAY=:0.0
# Get all window IDs
for win in $(xdotool search --all --class "$CLASS_NAME"); do
    # Send Ctrl+Shift+R to each window
    xdotool windowactivate "$win"
    sleep 1
    xdotool key --window "$win" F5
    sleep 1
done