#!/bin/bash

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_TYPE=simple

change_interval=300
idx=0

while true; do
  wallpapers=("$WALLPAPERS_PATH"/*)
  swww img "${wallpapers[$idx]}"

  ((idx++))
  if [[ $idx -ge "${#wallpapers[@]}" ]]; then
    idx=0
  fi

  sleep "$change_interval"
done
