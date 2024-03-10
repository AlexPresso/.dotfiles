#!/bin/bash

source "./scripts/variables.sh"

##########################
# VARS
##########################

packages=(
  hyprland hyprpaper #Hyprland
  alacritty #TTY
  qt5ct qt6ct #QT
  pipewire pipewire-pulse wireplumber #Audio + Bluetooth Audio
  pamixer brightnessctl playerctl #Controllers
  waybar wofi neofetch #Look & feel
  thunar thunar-archive-plugin gvfs gvfs-mtp #Filemanager UI
  pavucontrol #Audio manager UI
  blueman #Bluetooth manager UI
  networkmanager #Networkmanager... (UI)

  #... feel free to recommend other packages
)

aur_packages=(
  hyprlock hypridle #More Hyprland
  swaync wlogout

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

_info "Installing packages..."

_pacman base-devel git curl wget

# shellcheck disable=SC2154
git clone https://aur.archlinux.org/paru.git "$tmp_dir/paru"
(cd "$tmp_dir/paru" && makepkg -si --noconfirm 2>&1)

_pacman "${packages[@]}"
_paru "${aur_packages[@]}"

ask "Install other utils packages, like nano, htop, nmap..." \
  "_pacman ${util_packages[*]}" \
  do_nothing

_info "Done installing packages."
