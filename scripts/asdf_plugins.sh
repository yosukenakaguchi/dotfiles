#!/bin/bash

set -e
# shellcheck disable=SC1091
source "./scripts/utils.sh"

export ASDF_HASHICORP_OVERWRITE_ARCH=amd64

# shellcheck disable=SC2013
for plugin in $(awk '{print $1}' ~/.tool-versions); do
  if ! is_dir ~/.asdf/plugins/"$plugin"; then
    asdf plugin add "$plugin"
  fi
done

# Install and Uninstall asdf plugins
for plugin in $(asdf plugin list); do
  specified_versions=$(grep "$plugin" ~/.tool-versions | awk '{$1=""; print $0}')
  installed_versions=$(asdf list "$plugin" 2>&1 | sed 's/\*//g' | xargs)

  # Install asdf plugin
  for specified_version in $specified_versions; do
    if ! echo "$installed_versions" | grep -q "$specified_version"; then
      log "Install: $plugin $specified_version"
      asdf install "$plugin" "$specified_version"
    else
      log "Already installed: $plugin $specified_version"
    fi
  done

  # Uninstall asdf plugin
  for installed_version in $installed_versions; do
    if ! echo "$specified_versions" | grep -q "$installed_version"; then
      log "Uninstall: $plugin $installed_version"
      asdf uninstall "$plugin" "$installed_version"
    fi
  done
done