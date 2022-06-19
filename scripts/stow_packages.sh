#!/bin/sh

set -e

# Utils
log() {
  message=$1
  echo 📌 "$message"
}

is_dir() {
  path="$1"
  [ -d "$path" ]
}

ensure_dir() {
  path="$1"
  if ! is_dir "$path"; then
    mkdir -p "$path"
  fi
}

HOME_DIR=$HOME
STOW_PACKAGES_PATH="$(cd "$(dirname "$0")" && cd ../packages && pwd)"

# TODO:create -u unlink option

log 'Link dotfiles'
ensure_dir ~/.config/alacritty

# shellcheck disable=SC2046
stow -v -d "$STOW_PACKAGES_PATH" -t "$HOME_DIR" --adopt $(ls "$STOW_PACKAGES_PATH")
