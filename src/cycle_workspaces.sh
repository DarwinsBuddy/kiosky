#!/bin/bash
source "/home/pi/.config/i3/env.sh"

while true; do
    workspaces=$(i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) -t get_workspaces | jq length)
    for i in $(seq 1 $workspaces);
    do
        echo "i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) workspace $i"
        i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) workspace $i
        sleep "$TIMEOUT"
    done
done
