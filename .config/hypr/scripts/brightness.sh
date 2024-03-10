#!/bin/bash

icon_dir="$HOME/.config/swaync/icons"
current_value="$(get_value | sed 's/%//')"
notification_timeout=1000

get_icon() {
  if [ "$current_value" -le "20" ]; then
    range_value="20"
  elif [ "$current_value" -le "40" ]; then
    range_value="40"
  elif [ "$current_value" -le "60" ]; then
    range_value="60"
  elif [ "$current_value" -le "80" ]; then
    range_value="80"
  else
    range_value="100"
  fi

  echo "$icon_dir/brightness-$range_value.png"
}

notify() {
	notify-send \
	  -e \
	  -h string:x-canonical-private-synchronous:brightness_notif \
	  -h "int:value:$current_value" \
	  -u low \
	  -i "$(get_icon)" "Brightness : $current_value%"
}

change_value() {
	brightnessctl set "$1" && notify
}

get_value() {
  brightnessctl -m | cut -d, -f4
}

case "$1" in
	"--get") get_value ;;
	"--inc") change_value "+10%" ;;
	"--dec") change_value "10%-" ;;
	*) get_value ;;
esac
