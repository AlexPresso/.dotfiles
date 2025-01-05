#!/bin/bash

_log() {
  gum log --level "$1" "${@:2}"
}

ask_yn() {
  gum confirm "  $1 ?" \
    --prompt.foreground="$header_color" \
    --selected.background="$primary_color" \
    --selected.foreground="$secondary_color" && echo "yes" || echo "no"
}

ask_choice() {
  local options
  options=$(printf "%s\n" "${@:3}")

  echo "$options" | gum choose \
    --header "  $1 ?" \
    --cursor.foreground="$primary_color" \
    --header.foreground="$header_color" \
    --selected.foreground="$primary_color" \
    --item.foreground="$secondary_color" \
    --height=10 \
    "$2"
}

_print_value() {
  local value
  value=$(printf "%s" "$2" | tr '\n' ', ')
  echo "$(gum style --foreground "$primary_color" "$1"): $(gum style --foreground "$secondary_color" "$value")"
}

handle_error() {
  _log "error" "An error occurred while running: $BASH_COMMAND"
  exit 1
}

prepare_installation() {
  mkdir -p "$inst_tmp_dir"

  if ! which "gum" &> /dev/null; then
    echo "Gum package is required to run this script, installing it now..."
    _pacman "gum"
  fi

  clear
  gum style \
    --border normal \
    --margin "1" \
    --padding "1 2" \
    --border-foreground "$primary_color" \
    "AlexPresso's dotfiles installer"
}

end_installation() {
  rm -rf "$inst_tmp_dir"

  if [[ "$v_reboot" == "yes" ]]; then
    sudo reboot
  fi
}

_pacman() {
  sudo pacman -S --needed --noconfirm "$@"
}
_aur_install() {
  "$v_package_manager" -S --needed --noconfirm "$@"
}
