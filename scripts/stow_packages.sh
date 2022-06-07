#!/bin/sh

set -e

HOME_DIR=$HOME
STOW_PACKAGES_PATH="$HOME_DIR"/dotfiles/packages

# TODO:create -u unlink option

# shellcheck disable=SC2046
stow -v -d "$STOW_PACKAGES_PATH" -t "$HOME_DIR" --adopt $(ls "$STOW_PACKAGES_PATH")
