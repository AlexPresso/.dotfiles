#!/bin/bash

##########################
# VARS
##########################

# shellcheck disable=SC2034
export inst_tmp_dir="/tmp/tmp_dotfiles"

export primary_color="#FFA500"
export secondary_color="#808080"
export header_color="#FFFFFF"

# Default values are used for debugging (when manually running specific stage)
export v_update_packages="${v_update_packages:-yes}"
export v_additional_packages="${v_additional_packages:-$(cat ./scripts/utils/additional_packages)}"
export v_package_manager="${v_package_manager:-paru}"
export v_terminal="${v_terminal:-terminator}"
export v_kb_layout="${v_kb_layout:-us}"
export v_has_nvidia="${v_has_nvidia:-no}"
export v_reboot="${v_reboot:-no}"
