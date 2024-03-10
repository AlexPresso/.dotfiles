#!/bin/bash

##########################
# STAGES
##########################

check_version() {
  source "./version.sh" || (_error "Please 'cd' into the script directory before running it" && exit 1)
}

update_packages() {
  _info "Updating packages..."
  sudo pacman -Syu --noconfirm

  _info "Done updating packages."
}

copy_dotfiles() {
  _info "Copying dotfiles..."

  cp -Rf "./.config" "$HOME/.config"
  cp -R "./wallpapers" "$HOME/wallpapers"

  _info "Done copying dotfiles."
}

prepare_installation() {
  mkdir -p "$tmp_dir"
}
end_installation() {
  rm -rf "$tmp_dir"
}

##########################
# ENTRYPOINT
##########################
trap handle_error ERR

check_version

source "./scripts/variables.sh"
source "./scripts/utils.sh"

# shellcheck disable=SC2154
ask "Run AlexPresso's dotfiles installer v$installer_version" \
  do_nothing \
  exit

prepare_installation

ask "Do you want to update packages before installation (optional but recommended)" \
  update_packages \
  do_nothing

run_stage "packages"

ask "Do you have an nvidia GPU" \
  "run_stage nvidia" \
  do_nothing

copy_dotfiles

#end_installation

_success "Done installing, it's recommended to reboot your system for everything to start properly."
ask "Reboot now" \
  "sudo reboot" \
  do_nothing
