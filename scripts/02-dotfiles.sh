#!/bin/bash

source "./scripts/utils/variables.sh"
source "./scripts/utils/functions.sh"


##########################
# ENTRYPOINT
##########################

if [[ "$v_install_dot_files" == "y" ]]; then
  _info "Copying dotfiles..."

  mkdir -p "$HOME/.config"
  mkdir -p "$HOME/wallpapers"

  cp -Rf ./.config/* "$HOME/.config"
  cp -R ./wallpapers/* "$HOME/wallpapers"

  _info "Configuring dotfile..."
  find "$HOME/.config" -type f | while IFS= read -r file; do
    replace_variables "$file"

    if [[ $(basename "$file") == *.sh ]]; then
      chmod +x "$file"
    fi
  done
  _success "Done injecting your settings."

  _success "Done copying dotfiles."
fi
