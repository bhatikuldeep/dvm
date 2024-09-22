#!/bin/bash

# Directory where all decK versions are stored
DECK_DIR="$HOME/.deck_versions"

# Symlink for the current version of decK
SYMLINK_PATH="/usr/local/bin/deck"

# Function to determine the system architecture
get_arch() {
  arch=$(uname -m)
  if [ "$arch" = "x86_64" ]; then
    echo "amd64"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    echo "arm64"
  else
    echo "Unsupported architecture: $arch"
    exit 1
  fi
}

# Function to check if a URL is reachable
check_url() {
  url=$1
  if curl --output /dev/null --silent --head --fail "$url"; then
    echo "URL exists: $url"
    return 0
  else
    echo "URL does not exist or is unreachable: $url"
    return 1
  fi
}

# Function to install and switch to a specific version of decK
install_and_switch_deck() {
  local version=$1
  local os=$(uname)
  local url
  local arch

  if [ "$os" = "Darwin" ]; then
    url="https://github.com/Kong/deck/releases/download/v${version}/deck_${version}_darwin_all.tar.gz"
  elif [ "$os" = "Linux" ]; then
    arch=$(get_arch)
    url="https://github.com/Kong/deck/releases/download/v${version}/deck_v${version}_linux_${arch}.tar.gz"
  else
    echo "Unsupported OS: $os"
    exit 1
  fi

  echo "Checking URL: $url"
  if ! check_url "$url"; then
    echo "The URL is not valid. Please check the version or manually download the package."
    exit 1
  fi

  echo "Downloading decK version ${version}..."
  mkdir -p "${DECK_DIR}/${version}"
  curl -sL "$url" -o "${DECK_DIR}/${version}/deck.tar.gz"

  echo "Extracting decK version ${version}..."
  tar -xzf "${DECK_DIR}/${version}/deck.tar.gz" -C "${DECK_DIR}/${version}"

  # Ensure the binary is executable
  chmod +x "${DECK_DIR}/${version}/deck"

  # Switch to the newly installed version
  echo "Switching to decK version ${version}..."
  sudo ln -sf "${DECK_DIR}/${version}/deck" "$SYMLINK_PATH"

  # Verify the symlink
  if [ -L "$SYMLINK_PATH" ]; then
    echo "Symbolic link updated to ${version}!"
  else
    echo "Failed to update the symbolic link."
    exit 1
  fi

  # Check if the deck command is now available
  if command -v deck >/dev/null 2>&1; then
    echo "decK version $(deck version | awk '{print $2}') installed and switched to ${version}!"
  else
    echo "deck command not found after switch. Please check the symlink."
  fi
}

# Function to switch to a specific version of decK
switch_deck() {
  local version=$1

  if [ ! -d "${DECK_DIR}/${version}" ]; then
    echo "decK version ${version} is not installed."
    read -p "Do you want to install it? (y/n): " yn
    case $yn in
      [Yy]* ) install_and_switch_deck $version;;
      * ) exit;;
    esac
  fi

  echo "Switching to decK version ${version}..."
  sudo ln -sf "${DECK_DIR}/${version}/deck" "$SYMLINK_PATH"

  # Verify the symlink
  if [ -L "$SYMLINK_PATH" ]; then
    echo "Symbolic link updated to ${version}!"
  else
    echo "Failed to update the symbolic link."
    exit 1
  fi

  # Check if the deck command is now available
  if command -v deck >/dev/null 2>&1; then
    echo "Switched to decK version $(deck version | awk '{print $2}')!"
  else
    echo "deck command not found after switch. Please check the symlink."
  fi
}

# Function to list all installed versions
list_deck_versions() {
  if [ -d "$DECK_DIR" ]; then
    current_version=$(deck version 2>/dev/null | awk '{print $2}' | sed 's/v//')
    echo "Installed decK versions:"
    for version in $(ls -1 "$DECK_DIR"); do
      if [ "$version" = "$current_version" ]; then
        echo "  * $version (current)"
      else
        echo "    $version"
      fi
    done
    if [ -z "$current_version" ]; then
      echo "No current version found."
    fi
  else
    echo "No versions found."
  fi
}

# Function to show usage
usage() {
  echo "Usage: $0 [install <version> | switch <version> | list]"
  exit 1
}

# Main logic
case $1 in
  install)
    [ -z "$2" ] && usage
    install_and_switch_deck $2
    ;;
  switch)
    [ -z "$2" ] && usage
    switch_deck $2
    ;;
  list)
    list_deck_versions
    ;;
  *)
    usage
    ;;
esac
