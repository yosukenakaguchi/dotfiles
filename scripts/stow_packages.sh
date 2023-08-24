#!/bin/sh

set -e
source ./scripts/utils.sh

HOME_DIR=$HOME
STOW_PACKAGES_PATH="$(cd "$(dirname "$0")" && cd ../packages && pwd)"

# TODO:create -u unlink option

log 'Link dotfiles'

# shellcheck disable=SC2046
stow -v -d "$STOW_PACKAGES_PATH" -t "$HOME_DIR" --adopt $(ls "$STOW_PACKAGES_PATH")
