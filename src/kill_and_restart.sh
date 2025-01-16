SCRIPT="${1:-cycle_workspaces.sh}"

#!/bin/bash

# Check if the script is already running
# Get the PID of the running script using ps and grep
PID=$(ps aux | grep "/home/pi/.config/i3/$SCRIPT" | grep -v grep | awk '{print $2}')
echo "$SCRIPT PID=$PID"
# Check if the PID variable is set (i.e., the script is running)
if [ -n "$PID" ]; then
    # Kill the process
    echo "Killing process $PID..."
    kill "$PID"
    # If the process is still running, force kill it
    if ps -p "$PID" > /dev/null; then
        echo "Process did not terminate gracefully, force killing..."
        kill -9 "$PID"
    else
        echo "Process $PID has been terminated."
    fi
else
    echo "No running process found for '$SCRIPT'."
fi

# Start the script
"/home/pi/.config/i3/$SCRIPT" &
