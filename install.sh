#!/bin/bash

##########################
# ENTRYPOINT
##########################
source "./scripts/utils/variables.sh"
source "./scripts/utils/functions.sh"

trap handle_error ERR

# shellcheck disable=SC2154
check_version
_info "AlexPresso's dotfiles installer v$installer_version"

prepare_installation

export v_update_packages=$(ask_yn "Do you want to update packages before installation (optional but recommended)")
export v_package_manager=$(ask_choice "Which package manager do you want to install" "paru" "yay")
export v_util_packages=$(ask_yn "Do you want to install util packages (nano, nmap, htop, dig, ...)")
export v_terminal=$(ask_choice "Which terminal do you want to install" "alacritty" "kitty" "terminator")
export v_qt_version=$(ask_choice "Which QT version do you want to use" "qt5ct" "qt6ct")
export v_monitor_resolution=$(ask_choice "What's your monitor resolution" "1280x720" "1920x1080" "2560x1440" "2048x1080" "3840x2160")
export v_monitor_refresh_rate=$(ask_choice "What's your monitor refresh rate (Hz)" "60" "120" "144" "160" "200" "240")
export v_has_nvidia=$(ask_yn "Do you have an nvidia GPU")
export v_install_dot_files=$(ask_yn "Do you want to install my dotfiles")

if [[ "$(ask_yn "Run installation with these parameters")" == "n" ]]; then
  exit 0
fi

files=(./scripts/*.sh) #Arrays are indexed Globs are not
for file in "${files[@]}"; do
  # shellcheck disable=SC1090
  source "$file"
done

#clear
_success "Done installing, it's recommended to reboot your system for everything to start properly."
export v_reboot=$(ask_yn "Reboot now")

end_installation
