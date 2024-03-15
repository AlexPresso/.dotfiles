#!/bin/bash

source "./scripts/utils/variables.sh"
source "./scripts/utils/functions.sh"


##########################
# ENTRYPOINT
##########################

_info "Copying dotfiles..."

cp -Rf "./.config" "$HOME/.config"
cp -R "./wallpapers" "$HOME/wallpapers"

_info "Injecting your chosen settings..."
find "$HOME/.config" -type f | while IFS= read -r file; do
  replace_variables "$file"
done
_success "Done injecting your settings."

_success "Done copying dotfiles."
