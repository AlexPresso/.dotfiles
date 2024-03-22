#!/bin/bash

swww query || swww init

change_interval=300
idx=0

while true; do
  wallpapers=("$WALLPAPERS_PATH"/*)
  swww img "${wallpapers[$idx]}" \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-fps 60

  ((idx++))
  if [[ $idx -ge "${#wallpapers[@]}" ]]; then
    idx=0
  fi

  sleep "$change_interval"
done
