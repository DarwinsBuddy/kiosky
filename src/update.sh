#!/bin/bash
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

force=${1:-0}
echo "[$(date '+%d/%m/%Y %H:%M:%S')] UPDATE (force=$force)"
bash "$SCRIPT_DIR/update_config.sh"
if [ $? -eq 0 ] && [ "$force" -eq 0 ]; then
    echo "Config up to date... not updating layout or re-launching."
    exit 1
else
    echo "Config updated. Updating layouts and re-launching"
fi
sleep 2
echo "Updating layouts..."
bash "$SCRIPT_DIR/update_layouts.sh"
sleep 2
echo "Relaunching..."
bash "$SCRIPT_DIR/launch.sh"
