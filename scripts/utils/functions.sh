#!/bin/bash

##########################
# UTILS
##########################

_log() {
  printf "\e[0;37m[%s] \e[0m[%s] %b" "$(date '+%Y-%m-%d %H:%M:%S')" "$1" "$2$3\e[0m"
}
_info() {
  _log "INFO" "\e[0m" "$1\n"
}
_error() {
  _log "ERROR" "\e[0;31m" "$1\n"
}
_success() {
  _log "SUCCESS" "\e[0;32m" "$1\n"
}

ask_yn() {
  while true; do
    >&2 printf "\e[0m[%s] \e[94m%s ? (y/n) : \e[0m" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
    read -r answer

    case "$answer" in
      [Yy]*) echo "y" && return 0;;
      [Nn]*) echo "n" && return 0;;
      *) >&2 printf "Unknown answer, please choose between 'y' or 'n'.\n"
    esac
  done
}

ask_choice() {
  local message="$1"
  shift
  local options=("$@")

  while true; do
    >&2 printf "\e[0m[%s] \e[94m%s ? \e[0m\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$message"

    for ((i=0; i < ${#options[@]}; i++)) do
      >&2 printf "\e[0m\e[94m%d)\e[0m %s " "$((i+1))" "${options[i]}"
    done

    >&2 printf "\n   \e[0mEnter your choice (1-%d): " "${#options[@]}"
    read -r answer

    if [ "$answer" -ge 1 ] && [ "$answer" -le "${#options[@]}" ]; then
      echo "${options[answer-1]}"
      return 0
    else
      >&2 printf "Invalid choice. Please choose a number between 1 and %d.\n" "${#options[@]}"
    fi
  done
}

handle_error() {
  exit 1
}

prepare_installation() {
  mkdir -p "$inst_tmp_dir"
}

end_installation() {
  rm -rf "$inst_tmp_dir"

  if [[ "$v_reboot" == "y" ]]; then
    sudo reboot
  fi
}

check_version() {
  source "./version.sh" || (_error "Please 'cd' into the script directory before running it" && exit 1)
}

_pacman() {
  sudo pacman -S --needed --noconfirm "$@"
}
_aur_install() {
  "$v_package_manager" -S --needed --noconfirm "$@"
}

replace_variables() {
  sed -i "s/@rp_terminal@/$v_terminal/g" "$1"
  sed -i "s/@rp_qt_version@/$v_qt_version/g" "$1"
  sed -i "s/__rp_monitor_resolution__/$v_monitor_resolution/g" "$1"
  sed -i "s/__rp_monitor_refresh_rate__/$v_monitor_refresh_rate/g" "$1"
}
