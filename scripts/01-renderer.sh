#!/bin/bash

if [ "${v_gpu_brand}" == "none" ]; then
  return
fi

declare -A gpu_drivers=(
  ["nvidia"]="nvidia-dkms nvidia-utils lib32-nvidia-utils"
  ["amd"]="mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon"
  ["intel"]="mesa lib32-mesa xf86-video-intel vulkan-intel lib32-vulkan-intel"
)

_log "info" "Enabling multilib repository..."
sudo sed -i '/\[multilib\]/,/Include/s/^#//g' /etc/pacman.conf

_log "info" "Installing GPU drivers..."

read -r -a drivers_to_install <<< "${gpu_drivers[${v_gpu_brand}]}"
_pacman "${drivers_to_install[@]}"
