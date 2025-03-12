#!/bin/bash

# URL to fetch layouts
LAYOUTS_URL="<your layouts url>"

# Output directory
OUTPUT_DIR="./layouts"

# Ensure script fails on error
set -e

# Fetch JSON data
echo "Fetching layouts..."
JSON_DATA=$(curl -fsSL "$LAYOUTS_URL")

# Validate JSON
if ! echo "$JSON_DATA" | jq empty 2>/dev/null; then
    echo "Error: Invalid JSON received!"
    exit 1
fi

# Create output directory if not exists
mkdir -p "$OUTPUT_DIR"

# Extract layouts and write to files
# CHANGE THIS W.R.T. TO THE RESPONSE OF ABOVE CALL
echo "Saving layouts..."
echo "$JSON_DATA" | jq -c '.data[]' | while read -r entry; do
    NAME=$(echo "$entry" | jq -r '.name')
    DEFINITION=$(echo "$entry" | jq -r '.definition')

    # Output file path
    FILE_PATH="$OUTPUT_DIR/$NAME.json"

    # Write the definition to the file
    echo "$DEFINITION" > "$FILE_PATH"

    echo "Saved: $FILE_PATH"
done

echo "All layouts saved successfully."
