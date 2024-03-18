#!/bin/bash

source "./scripts/utils/variables.sh"
source "./scripts/utils/functions.sh"


##########################
# VARS
##########################

nvidia_packages=(
  nvidia-dkms
  nvidia-settings
  nvidia-utils
  libva
  libva-nvidia-driver-git
)

nvidia_modules=("nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm")


##########################
# ENTRYPOINT
##########################

if [[ "$v_has_nvidia" == "y" ]]; then
  _info "Installing nvidia packages..."
  _aur_install "${nvidia_packages[@]}"
  _info "Done installing nvidia packages."

  _info "Adding nvidia modules to initramfs..."
  source "/etc/mkinitcpio.conf" #Since the syntax is same as shell we can do that :)

  if [ -z "${MODULES[*]}" ]; then
    MODULES=("${nvidia_modules[@]}")
  else
    for module in "${nvidia_modules[@]}"; do
      found=false

      for existing_module in "${MODULES[@]}"; do
        if [ "$existing_module" == "$module" ]; then
          found=true
          break
        fi
      done

      if ! $found; then
        MODULES+=("$module")
      fi
    done
  fi

  sudo sed -i "/^MODULES=/c\MODULES=(${MODULES[*]})" "/etc/mkinitcpio.conf"
  sudo mkinitcpio -P
  _success "Done adding nvidia modules to initramfs"

  _info "Enabling nvidia kernel module..."
  nv_probe_conf="/etc/modprobe.d/nvidia.conf"
  if [[ ! -f "$nv_probe_conf" ]]; then
    echo "options nvidia-drm modeset=1" | sudo tee -a "$nv_probe_conf"
  fi
  _success "Done enabling nvidia kernel module."

  grub_conf="/etc/default/grub"
  if [[ -f "$grub_conf" ]]; then
    _info "Detected GRUB, injecting nvidia kernel module into GRUB modules"

    if ! sudo grep -q "nvidia-drm.modeset=1" "$grub_conf"; then
      sudo sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"/\1 nvidia-drm.modeset=1"/' "$grub_conf"
      sudo grub-mkconfig -o /boot/grub/grub.cfg
    fi

    _success "Done injecting nvidia kernel module into GRUB modules."
  fi
fi
