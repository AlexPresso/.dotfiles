#!/bin/bash

source "./scripts/utils/variables.sh"
source "./scripts/utils/functions.sh"

trap handle_error ERR

##########################
# ENTRYPOINT
##########################

prepare_installation

export v_update_packages=$(ask_yn "Do you want to update packages before installation (optional but recommended)")
_print_value "Update Packages" "$v_update_packages"
export v_package_manager=$(ask_choice "Which AUR package-manager do you want to install" --limit=1 "paru" "yay")
_print_value "AUR Package-Manager" "$v_package_manager"
export v_additional_packages=$(ask_choice "Select additional packages to install" --no-limit "$(cat ./scripts/utils/additional_packages)")
_print_value "Additional Packages To Install" "$v_additional_packages"
export v_terminal=$(ask_choice "Which terminal do you want to install" --limit=1 "alacritty" "kitty" "terminator")
_print_value "Terminal" "$v_terminal"
export v_gpu_brand=$(ask_choice "Select your GPU brand" --limit=1 "nvidia" "amd" "intel" "none")
_print_value "GPU Brand" "$v_gpu_brand"
export v_kb_layout=$(ask_choice "What's your keyboard layout" --limit=1 "$(localectl list-keymaps)")
_print_value "Keyboard Layout" "$v_kb_layout"

if [[ "$(ask_yn "Run installation with these parameters")" == "no" ]]; then
  exit 0
fi

echo ""
files=(./scripts/*.sh) #Arrays are indexed Globs are not
for file in "${files[@]}"; do
  # shellcheck disable=SC1090
  source "$file"
done

#clear
#
#export v_reboot=$(ask_yn "Reboot now (recommended)")
#end_installation
