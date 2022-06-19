#!/bin/bash

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

# Add asdf plugins
# shellcheck disable=SC2013
for plugin in $(awk '{print $1}' ~/.tool-versions); do
  if ! is_dir ~/.asdf/plugins/"$plugin"; then
    asdf plugin add "$plugin"
  fi
done

is_runtime_versions_changed() {
  plugin="$1"
  specified=$(grep "$plugin" ~/.tool-versions | awk '{$1=""; print $0}')
  installed=$(asdf list "$plugin" 2>&1)

  is_changed=
  for version in $specified; do
    match=$(echo "$installed" | grep "$version")
    [ -z "$match" ] && is_changed=1
  done

  [ "$is_changed" ]
}

# Install asdf plugins
for plugin in $(asdf plugin list); do
  if is_runtime_versions_changed "$plugin"; then
    # if [ "$plugin" = nodejs ]; then log "Import release team keyring for Node.JS"
    #     bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
    # fi
    log "Install runtime: $plugin"
    asdf install "$plugin"
  fi
done
