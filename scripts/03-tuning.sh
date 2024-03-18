#!/bin/bash

source "./scripts/utils/variables.sh"
source "./scripts/utils/functions.sh"


##########################
# ENTRYPOINT
##########################

hypr_env_conf="$HOME/.config/hypr/env.conf"
if [[ "$v_has_nvidia" == "y" ]]; then
  {
    echo "env = LIBVA_DRIVER_NAME,nvidia"
    echo "env = GBM_BACKEND,nvidia-drm"
    echo "env = __GLX_VENDOR_LIBRARY_NAME,nvidia"
    echo "env = __GL_GSYNC_ALLOWED,1"
  } >> "$hypr_env_conf"
fi

if hostnamectl | grep -q "Chassis: vm"; then
  {
    echo "env = WLR_RENDERER_ALLOW_SOFTWARE,1"
  } >> "$hypr_env_conf"
fi
