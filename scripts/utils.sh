#!/bin/bash

log() {
  message="$1"
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