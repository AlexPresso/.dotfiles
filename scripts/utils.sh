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

ask() {
  while true; do
    printf "\e[0m[%s] \e[94m%s ? (y/n) : \e[0m" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
    read -r answer

    case "$answer" in
      [Yy]*) eval "$2" && return ;;
      [Nn]*) eval "$3" && return ;;
      *) printf "Unknown answer, please choose between 'y' or 'n'.\n"
    esac
  done
}
do_nothing() {
  echo "" > /dev/null
}

run_stage() {
  local script_path="./scripts/$1.sh"

  if [ -f "$script_path" ]; then
    # shellcheck source=/dev/null
    source "$script_path"
  else
    error "Cannot find script : $script_path"
    exit 1
  fi
}

handle_error() {
  exit 1
}

_pacman() {
  sudo pacman -S --needed --noconfirm "$@"
}
_paru() {
  paru -S --needed --noconfirm "$@"
}
