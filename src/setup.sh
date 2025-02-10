#!/bin/bash
source env.sh

## DELETE crontab
crontab -r

START="# ===kiosky:start==="
END="# ===kiosky:end==="
# Ensure both $KIOSK_CONFIG_FILE and $I3_CONFIG_FILE are set
if [ -z "$KIOSK_CONFIG_FILE" ] || [ -z "$I3_CONFIG_FILE" ]; then
  echo "Error: \$KIOSK_CONFIG_FILE and \$I3_CONFIG_FILE must be set."
  exit 1
fi

# Temporary file to hold the updated contents
temp_file=$(mktemp)

# Read content from KIOSK_CONFIG_FILE
kiosk_content=$(<"$KIOSK_CONFIG_FILE")

# Check if the target file contains the block between # ===kiosky:start=== and # ===kiosky:end===
if grep -q "$START" "$I3_CONFIG_FILE"; then
  # If the block exists, remove kiosky configs
  sed "/$START/,/$END/d" "$I3_CONFIG_FILE" > "$temp_file"
  echo "$START" >> "$temp_file"
  echo "$kiosk_content" >> "$temp_file"
  echo "$END" >> "$temp_file"
else
  # If the block doesn't exist, append it to the end of the target file
  cat "$I3_CONFIG_FILE" > "$temp_file"
  echo -e "\n$START\n$kiosk_content\n$END" >> "$temp_file"
fi

# Replace the original file with the updated temporary file
mv "$temp_file" "$I3_CONFIG_FILE"

# Replace all layouts
cp -ar "$LAYOUTS_DIR" "$I3_CONFIG_DIR"
# Replace scripts
cp "$KIOSKY_DIR/env.sh" "$I3_CONFIG_DIR"
cp "$KIOSKY_DIR/urls.sh" "$I3_CONFIG_DIR"
cp "$KIOSKY_DIR/cycle_workspaces.sh" "$I3_CONFIG_DIR"
cp "$KIOSKY_DIR/next_workspace.sh" "$I3_CONFIG_DIR"
cp "$KIOSKY_DIR/kill_and_restart.sh" "$I3_CONFIG_DIR"
cp "$KIOSKY_DIR/launch.sh" "$I3_CONFIG_DIR"
cp "$KIOSKY_DIR/reload.sh" "$I3_CONFIG_DIR"
cp "$KIOSKY_DIR/hdmi.sh" "$I3_CONFIG_DIR"

echo "The i3 config file has been updated. All scripts have been replaced"
# i3-msg --socket $(ls /run/user/$(id -u)/i3/ipc-socket.*) restart

## SETUP crontab again
cron_jobs=(
  "*/2 * * * * ~/.config/i3/next_workspace.sh"
  "*/10 * * * * ~/.config/i3/reload.sh"
  "0 22 * * * ~/.config/i3/hdmi.sh off"
  "0 7 * * * ~/.config/i3/hdmi.sh on"
)

{
  for job in "${cron_jobs[@]}"; do
    echo "$job"
  done
} | crontab -

$KIOSKY_DIR/launch.sh &

