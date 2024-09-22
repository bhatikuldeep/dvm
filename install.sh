#!/bin/bash

# Set the script name
SCRIPT_NAME="deck-version-manager.sh"
LINK_NAME="dvm"

# Function to display an error message and exit
function error_exit {
    echo "$1" >&2
    exit 1
}

# Check if the script file exists in the current directory
if [ ! -f "$SCRIPT_NAME" ]; then
    error_exit "Error: $SCRIPT_NAME not found in the current directory."
fi

# Make the script executable
chmod +x "$SCRIPT_NAME" || error_exit "Error: Failed to make $SCRIPT_NAME executable."

# Remove any existing symlink to avoid conflicts
if [ -L "/usr/local/bin/$LINK_NAME" ]; then
    sudo rm "/usr/local/bin/$LINK_NAME" || error_exit "Error: Failed to remove the existing symlink."
fi

# Create the symlink to /usr/local/bin
sudo ln -s "$(pwd)/$SCRIPT_NAME" "/usr/local/bin/$LINK_NAME" || error_exit "Error: Failed to create symlink."

echo "Installation complete. You can now use the '$LINK_NAME' command to manage deck versions."
