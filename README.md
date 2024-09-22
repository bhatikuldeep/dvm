# Deck Version Manager

The Deck Version Switcher is a bash script designed to manage different versions of the deck command-line tool by Kong. This script supports installing, switching between versions, and listing installed versions for both macOS and Linux systems.

The script:

- Downloads the specified deck version from GitHub as a Darwin-based file.
- Extracts the archive.
- Moves the binary to /usr/local/bin for system-wide access.

> **Warning:** Remove Existing Homebrew Installation (if applicable): If deck was previously installed via Homebrew, remove it to avoid conflicts: `brew uninstall deck`


## Prerequisites
- Ensure that you have curl and tar installed.

## Setup

1. Download the Script: Clone or download the script from the repository.

2. Run the Installation Script: This script will make the Deck Version Manager script executable and place it in /usr/local/bin for easy access.

```bash
chmod +x install.sh && ./install.sh
```

The `install.sh` script will:

- Make the `deck-version-manager.sh` script executable.

- Create a symbolic link called dvm in /usr/local/bin, allowing you to use the dvm command from anywhere on your system.

> **Note:**  You may need to use sudo if you encounter permission issues.

## Usage

1. Install a Specific Version

    ```bash
    dvm install <version>
    ```

    Example:
    ```bash
    dvm install 1.39.4
    ```
2. Switch to a Specific Version

    ```bash
    dvm switch <version>
    ```

    Example:
    ```bash
    dvm switch 1.38.0
    ```

3. List Installed Versions

    ```bash
    dvm list
    ```

    Example:
    ```bash
    dvm list
    ```
## How to Uninstall

1. Run the uninstall script: 

    ```bash
    chmod +x uninstall.sh && ./uninstall.sh
    ```

### What This Script Does:
- Removes the symbolic link (`dvm`): This ensures that the `dvm` command will no longer be available system-wide.


This script assumes that the `deck-version-manager.sh` is in the same directory from which you run the `uninstall.sh` script. If the script is located elsewhere, you might need to modify the script to point to the correct location.