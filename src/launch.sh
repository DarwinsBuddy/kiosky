#!/bin/bash

DELAY="1"

source "/home/pi/.config/i3/env.sh"

# Kill all browser windows
pkill chromium
sleep 2
ARGS="--new-window --disable-application-cache --disk-cache-size=0 --disable-features=Translate --hide-scrollbars"

# Get the size of the array
num_layouts=${#layouts[@]}

# kill all workspaces
#!/bin/bash
LIVE_WORKSPACES=$(i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) -t get_workspaces | jq length)
for i in $(seq $LIVE_WORKSPACES -1 1);
do
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "[workspace=\"$i\"] kill"
    sleep 2
done
sleep 2
echo "Hide cursor"
# hide the cursor
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec unclutter -idle 0"
echo "Launching chromium"
# define layout for all workspaces
echo "LAYOUTS: $num_layouts"
for i in $(seq 1 "$num_layouts");
do
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "workspace $i;"
    sleep 1
    echo "Adding layout ${layouts[$((i-1))]:-4}"
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "append_layout /home/pi/.config/i3/layouts/${layouts[$((i-1))]:-4}.json"
    sleep $DELAY
done
for url in "${urls[@]}"; do
    i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) "exec chromium $ARGS --app=\"$url\""
    sleep $DELAY
done

# hide status bar
i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) bar mode hide