#!/bin/bash

##########################
# VARS
##########################

# shellcheck disable=SC2034
export inst_tmp_dir="/tmp/tmp_dotfiles"

#Default values are used for debugging (when manually running specific stage)
export v_update_packages="${v_update_packages:-y}"
export v_package_manager="${v_package_manager:-paru}"
export v_util_packages="${v_util_packages:-n}"
export v_terminal="${v_terminal:-terminator}"
export v_kb_layout="${v_kb_layout:-us}"
export v_qt_version="${v_qt_version:-qt6ct}"
export v_monitor_resolution="${v_monitor_resolution:-1920x1080}"
export v_monitor_refresh_rate="${v_monitor_refresh_rate:-60}"
export v_has_nvidia="${v_has_nvidia:-n}"
export v_install_dot_files="${v_install_dot_files:-y}"
export v_reboot="${v_reboot:-n}"
