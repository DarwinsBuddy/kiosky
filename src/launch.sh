#!/bin/bash

# Kill all browser windows
pkill chromium

ARGS="--new-window"
urls=(
    "https://weirdorconfusing.com/"
    "https://orf.at"
    "http://corndog.io/"
    "https://topfdeckel.at/tageskarte"
    "https://www.bbc.com/weather/2761369"
    "https://metalab.at"
    "https://www.window-swap.com/Window"
    "https://puginarug.com/"
)

# Get the size of the array
array_size=${#urls[@]}
TARGET_WORKSPACES=$(( (array_size + 3) / 4 ))

# kill all workspaces
#!/bin/bash
LIVE_WORKSPACES=$(i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) -t get_workspaces | jq length)
for i in $(seq 1 $LIVE_WORKSPACES);
do
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "[workspace=\"$i\"] kill"
done

echo "Hide cursor"
# hide the cursor
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec unclutter -idle 0"
echo "Launching chromium"
# define layout for all workspaces
for i in $(seq 1 $TARGET_WORKSPACES);
do
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "workspace $i; append_layout /home/pi/.config/i3/layouts/layout4.json"

done
sleep 1
for url in "${urls[@]}"; do
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec chromium $ARGS --app=$url"
    sleep .5
done