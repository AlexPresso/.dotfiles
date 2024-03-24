#!/bin/bash

source "./scripts/utils/variables.sh"
source "./scripts/utils/functions.sh"


##########################
# VARS
##########################

packages=(
  hyprland hyprlock hypridle #Hyprland
  pipewire pipewire-pulse wireplumber #Audio + Bluetooth Audio
  pamixer brightnessctl playerctl #Controllers
  waybar wofi neofetch swww #Look & feel
  thunar thunar-archive-plugin gvfs gvfs-mtp #Filemanager UI
  pavucontrol #Audio manager UI
  blueman #Bluetooth manager UI
  networkmanager #Networkmanager... (UI)
  swaync wlogout

  ttf-jetbrains-mono ttf-nerd-fonts-symbols

  #... feel free to recommend other packages
)

util_packages=(
  nano htop
  nmap bind

  #... feel free to recommend other packages
)


##########################
# ENTRYPOINT
##########################

if [[ "$v_update_packages" == "y" ]]; then
  _info "Updating packages..."
  sudo pacman -Syu --noconfirm
  _success "Done updating packages."
fi

_info "Installing required packages..."
_pacman base-devel git curl wget
_success "Done installing required packages."

_info "Installing kernel headers..."
for kernel in $(cat /usr/lib/modules/*/pkgbase); do
  _pacman "${kernel}-headers"
done
_success "Done installing kernel headers."

if ! which "paru" &> /dev/null; then
  _info "Installing $v_package_manager package manager..."
  rm -rf "$inst_tmp_dir/$v_package_manager"
  git clone "https://aur.archlinux.org/$v_package_manager" "$inst_tmp_dir/$v_package_manager"
  (cd "$inst_tmp_dir/$v_package_manager" && makepkg -si --noconfirm 2>&1)
  _success "Done installing $v_package_manager package manager."
fi

_info "Installing base packages..."
_aur_install \
  "${packages[@]}" \
  "${aur_packages[@]}" \
  "$v_terminal" \
  "$v_qt_version"
_success "Done installing base packages."

if [[ "$v_util_packages" == "y" ]]; then
  _info "Installing util packages..."
  _aur_install "${util_packages[@]}"
  _success "Done installing util packages."
fi

_info "Done running step: packages."
