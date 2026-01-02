#!/bin/bash

# Exit on error
set -e

# Load environment variables properly
if [ -f .env ]; then
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
        # Export the variable
        export "$line"
    done < .env
fi

# Verify environment variables are loaded
if [ -z "$RBXCLOUD_API_KEY" ] || [ -z "$UNIVERSE_ID" ] || [ -z "$PLACE_ID" ]; then
    echo "✗ Error: Missing required environment variables in .env file"
    echo "Required: RBXCLOUD_API_KEY, UNIVERSE_ID, PLACE_ID"
    exit 1
fi

echo "Universe ID: $UNIVERSE_ID"
echo "Place ID: $PLACE_ID"

# Build the place file
echo "Building project..."
rojo build -o roblox-game-1.rbxl default.project.json

# Publish to Roblox using rbxcloud
echo "Publishing to Roblox..."
if rbxcloud experience publish --universe-id "$UNIVERSE_ID" \
    --place-id "$PLACE_ID" \
    --api-key "$RBXCLOUD_API_KEY" \
    --version-type published \
    --filename roblox-game-1.rbxl; then
    echo "✓ Published successfully!"
else
    echo "✗ Publish failed!"
    echo "Make sure your API key has 'Universe > Places > Write' permission for Universe ID: $UNIVERSE_ID"
    exit 1
fi
