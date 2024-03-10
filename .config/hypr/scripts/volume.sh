#!/bin/bash

icon_dir="$HOME/.config/swaync/icons"
scripts_dir="$HOME/.config/hypr/UserScripts"

get_volume() {
  volume=$(pamixer --get-volume)
  if [[ "$volume" -eq "0" ]]; then
    echo "Muted"
  else
    echo "$volume%"
  fi
}

# Get icons
get_icon() {
  current=$(get_volume)
  if [[ "$current" == "Muted" ]]; then
    echo "$icon_dir/volume-mute.png"
  elif [[ "${current%\%}" -le 30 ]]; then
    echo "$icon_dir/volume-low.png"
  elif [[ "${current%\%}" -le 60 ]]; then
    echo "$icon_dir/volume-mid.png"
  else
    echo "$icon_dir/volume-high.png"
  fi
}

notify_user() {
  volume="$(get_volume)"
  args=(
    "-e"
    "-h" "string:x-canonical-private-synchronous:volume_notif"
    "-u" "low"
    "-i" "$(get_icon)" "Volume: $volume"
  )

  if [[ "$volume" != "Muted" ]]; then
    args+=("-h" "int:value:$(get_volume | sed 's/%//')")
    "$scripts_dir/sounds.sh" --volume
  fi

  notify-send args[*]
}

# Increase Volume
inc_volume() {
    if [ "$(pamixer --get-mute)" == "true" ]; then
        pamixer -u && notify_user
    fi
    pamixer -i 5 && notify_user
}

# Decrease Volume
dec_volume() {
    if [ "$(pamixer --get-mute)" == "true" ]; then
        pamixer -u && notify_user
    fi
    pamixer -d 5 && notify_user
}

# Toggle Mute
toggle_mute() {
	if [ "$(pamixer --get-mute)" == "false" ]; then
		pamixer -m && notify-send -e -u low -i "$icon_dir/volume-mute.png" "Volume Switched OFF"
	elif [ "$(pamixer --get-mute)" == "true" ]; then
		pamixer -u && notify-send -e -u low -i "$(get_icon)" "Volume Switched ON"
	fi
}

# Toggle Mic
toggle_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
		pamixer --default-source -m && notify-send -e -u low -i "$icon_dir/microphone-mute.png" "Microphone Switched OFF"
	elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer -u --default-source u && notify-send -e -u low -i "$icon_dir/microphone.png" "Microphone Switched ON"
	fi
}
# Get Mic Icon
get_mic_icon() {
    current=$(pamixer --default-source --get-volume)
    if [[ "$current" -eq "0" ]]; then
        echo "$icon_dir/microphone-mute.png"
    else
        echo "$icon_dir/microphone.png"
    fi
}

# Get Microphone Volume
get_mic_volume() {
    volume=$(pamixer --default-source --get-volume)
    if [[ "$volume" -eq "0" ]]; then
        echo "Muted"
    else
        echo "$volume%"
    fi
}

# Notify for Microphone
notify_mic_user() {
    volume=$(get_mic_volume)
    icon=$(get_mic_icon)
    notify-send -e -h int:value:"$volume" -h "string:x-canonical-private-synchronous:volume_notif" -u low -i "$icon" "Mic-Level: $volume"
}

# Increase MIC Volume
inc_mic_volume() {
    if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
        pamixer --default-source -u && notify_mic_user
    fi
    pamixer --default-source -i 5 && notify_mic_user
}

# Decrease MIC Volume
dec_mic_volume() {
  if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
    pamixer --default-source -u && notify_mic_user
  fi
    pamixer --default-source -d 5 && notify_mic_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
	get_icon
elif [[ "$1" == "--get-mic-icon" ]]; then
	get_mic_icon
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
else
	get_volume
fi