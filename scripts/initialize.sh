#!/bin/bash

set -e

# Utils
log() {
  message=$1
  echo 📌 "$message"
}

if [ "$(uname)" != "Darwin" ]; then
  echo "Not macOS!"
  exit 1
fi

if [ "$(uname -m)" != "arm64" ]; then
  echo "Not arm64!"
  exit 1
fi

chsh -s /bin/zsh

# Install xcode
xcode-select --install >/dev/null

# Install Homebrew
if [ ! -f /opt/homebrew/bin/brew ]; then
  log 'Setup Homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  log "Homebrew already installed."
fi
