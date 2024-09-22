#!/bin/bash

# Directory where all deck versions are stored
DECK_DIR="$HOME/.deck_versions"

# Remove the symbolic link from /usr/local/bin
if [ -L /usr/local/bin/dvm ]; then
    echo "Removing symbolic link /usr/local/bin/dvm..."
    sudo rm /usr/local/bin/dvm
    echo "Symbolic link removed."
else
    echo "Symbolic link /usr/local/bin/dvm not found. Skipping."
fi

# Check if DECK_DIR is not empty and prompt for removal
if [ -d "$DECK_DIR" ]; then
    if [ "$(ls -A $DECK_DIR)" ]; then
        echo "DECK_DIR ($DECK_DIR) is not empty."
        read -p "Do you want to remove the DECK_DIR directory and all installed deck versions? (y/n): " yn
        case $yn in
            [Yy]* )
                echo "Removing $DECK_DIR and all its contents..."
                rm -rf "$DECK_DIR"
                echo "$DECK_DIR removed."
                ;;
            * )
                echo "Skipping removal of $DECK_DIR."
                ;;
        esac
    else
        echo "DECK_DIR ($DECK_DIR) is empty. Skipping removal."
    fi
else
    echo "$DECK_DIR not found. Skipping."
fi

echo "Uninstallation complete."
