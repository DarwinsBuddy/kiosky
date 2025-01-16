#!/bin/bash

DELAY="1"

source "/home/pi/.config/i3/env.sh"

# Kill all browser windows
pkill chromium
sleep $DELAY
ARGS="--new-window --disable-application-cache --disk-cache-size=0 --disable-features=Translate"

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
sleep $DELAY
echo "Hide cursor"
# hide the cursor
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec unclutter -idle 0"
echo "Launching chromium"
# define layout for all workspaces
for i in $(seq 1 $TARGET_WORKSPACES);
do
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "workspace $i; append_layout /home/pi/.config/i3/layouts/layout4.json"
    sleep $DELAY
done
for url in "${urls[@]}"; do
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec chromium $ARGS --app=$url"
    sleep $DELAY
done