#!/bin/bash

# Ensure script fails on error
set -e

function check_config() {
  NEW_TIMESTAMP="$1"
  # Define the file path
  FILE_PATH="last_update.txt"
  # Check if the file exists
  if [ ! -f "$FILE_PATH" ]; then
      # If the file does not exist, create it with the new timestamp
      echo "$NEW_TIMESTAMP" > "$FILE_PATH"
      return 1
  else
      # Read the existing timestamp from the file
      EXISTING_TIMESTAMP=$(cat "$FILE_PATH")

      # Compare timestamps and update if they are different
      if [ "$NEW_TIMESTAMP" != "$EXISTING_TIMESTAMP" ]; then
          echo "$NEW_TIMESTAMP" > "$FILE_PATH"
          echo "Config updated"
          return 1
      else
          echo "Config is up to date."
          return 0
      fi
  fi
}


CONFIG_ID="1"
CONFIG_URL="<YOUR CONFIG URL>" # CHANGE THIS TO YOUR NEEDS
GET_CONFIG=$(cat <<EOF
curl -fsSL --get "$CONFIG_URL" \
--data-urlencode "fields=date_updated,urls.kiosk_urls_id.*,layouts.kiosk_layouts_id.name,layouts.kiosk_layouts_id.slots" \
--data-urlencode "filter[id][_eq]=$CONFIG_ID"
EOF
)
OUTPUT_FILE="config.sh"

# Fetch JSON data
echo "Fetching config..."
JSON_DATA=$(eval "$GET_CONFIG")

# Validate JSON
if ! echo "$JSON_DATA" | jq empty 2>/dev/null; then
    echo "Error: Invalid JSON received!"
    exit 1
fi

echo "Checking config..."
if check_config "$(echo "$JSON_DATA" | jq -r '.data.date_updated')" && [ $? -eq 0 ]; then
    echo "Exiting script since config is up to date"
    exit 0
fi

# Extract URLs from JSON
echo "Extracting URLs..."
URLS=$(echo "$JSON_DATA" | jq -r '.data.urls[].kiosk_urls_id.url')

# Extract Layout Names from JSON
echo "Extracting Layouts..."
LAYOUTS=$(echo "$JSON_DATA" | jq -r '.data.layouts[].kiosk_layouts_id.name')
LAYOUTS_SLOTS=$(echo "$JSON_DATA" | jq -r '.data.layouts[].kiosk_layouts_id.slots')

# Write to env.sh
echo "#!/bin/bash" > "$OUTPUT_FILE"

# Write URLs to env.sh
echo "urls=(" >> "$OUTPUT_FILE"
while IFS= read -r url; do
    echo "    \"$url\"" >> "$OUTPUT_FILE"
done <<< "$URLS"
echo ")" >> "$OUTPUT_FILE"

# Write Layouts to env.sh
echo "layouts=(" >> "$OUTPUT_FILE"
while IFS= read -r layout; do
    echo "    \"$layout\"" >> "$OUTPUT_FILE"
done <<< "$LAYOUTS"
echo ")" >> "$OUTPUT_FILE"

# Write Layouts slots to env.sh
echo "layouts_slots=(" >> "$OUTPUT_FILE"
while IFS= read -r layout; do
    echo "    \"$layout\"" >> "$OUTPUT_FILE"
done <<< "$LAYOUTS_SLOTS"
echo ")" >> "$OUTPUT_FILE"

# Make env.sh executable
chmod +x "$OUTPUT_FILE"

echo "URLs and layouts saved to $OUTPUT_FILE"
exit 1