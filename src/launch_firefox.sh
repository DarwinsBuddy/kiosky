#!/bin/bash

pkill firefox
sleep 5

ARGS="-new-window "

echo "Launching firefox"

i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "workspace 1; kill;"
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "workspace 1; append_layout /home/pi/.config/i3/layouts/layout4.json"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec firefox $ARGS https://weirdorconfusing.com/"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec firefox $ARGS https://orf.at"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec firefox $ARGS http://corndog.io/"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec firefox $ARGS https://topfdeckel.at/tageskarte"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "workspace 2; kill;"
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "workspace 2; append_layout /home/pi/.config/i3/layouts/layout4.json"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec firefox $ARGS https://www.bbc.com/weather/2761369"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec firefox $ARGS https://metalab.at"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec firefox $ARGS https://www.window-swap.com/Window"
sleep 1
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec firefox $ARGS https://puginarug.com/"
sleep 1