#!/bin/bash

_log "info" "Installing GNOME..."
gnome_packages=(
  gnome
  networkmanager
  gnome-tweaks
)

gnome_bloatware=(
  gnome-console
  gnome-contacts
  gnome-maps
  gnome-music
  gnome-remote-desktop
  gnome-tour
  gnome-weather
  gnome-software
  epiphany
  malcontent
  totem
  gnome-user-docs
)

_pacman "${gnome_packages[@]}"

_log "info" "Downloading extensions installer..."
rm -f ./install-gnome-extensions.sh; \
 wget \
  -N \
  -q "https://raw.githubusercontent.com/ToasterUwU/install-gnome-extensions/master/install-gnome-extensions.sh" \
  -O "${inst_tmp_dir}/install-gnome-extensions.sh" \
&& chmod +x "${inst_tmp_dir}/install-gnome-extensions.sh"

_log "info" "Installing and configuring GNOME extensions..."

gnome_extensions=(
  7 # https://extensions.gnome.org/extension/7/removable-drive-menu/
  6385 # https://extensions.gnome.org/extension/6385/steal-my-focus-window/
  6580 # https://extensions.gnome.org/extension/6580/open-bar/
  7332 # https://extensions.gnome.org/extension/7332/status-icons/
  6807 # https://extensions.gnome.org/extension/6807/system-monitor/
)

for extension in $(gnome-extensions list); do
  gnome-extensions disable "$extension"
done

"${inst_tmp_dir}/install-gnome-extensions.sh" --enable "${gnome_extensions[@]}"

_log "info" "Enabling GDM service..."

sudo systemctl enable gdm

_log "info" "Enabling NetworkManager..."

sudo systemctl disable wpa_supplicant
sudo systemctl enable NetworkManager
sudo systemctl disable --now systemd-resolved #DNS Resolution conflicting

_log "info" "Removing Gnome Bloatware..."
sudo pacman -Rsn "${gnome_bloatware[@]}" --noconfirm

_log "info" "Installing fonts"
_aur_install \
  ttf-ms-win11-auto \
  noto-fonts-cjk \
  noto-fonts-emoji
fc-cache -fv
