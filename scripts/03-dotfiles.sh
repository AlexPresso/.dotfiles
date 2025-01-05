#!/bin/bash

_log "info" "Installing dotfiles..."

mkdir -p "$HOME/.config"
mkdir -p "$HOME/wallpapers"

cp -Rf ./.config/* "$HOME/.config"
cp -Rf ./wallpapers/* "$HOME/wallpapers"

_aur_install ttf-jetbrains-mono

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.shell.extensions.user-theme name "Adwaita-dark"

gsettings set org.gnome.desktop.background picture-uri "file://$HOME/wallpapers/1.jpg"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/wallpapers/1.jpg"
gsettings set org.gnome.desktop.background primary-color "#3071AE"

gsettings set org.gnome.desktop.default-applications.terminal exec "alacritty"
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ""

gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true

dconf load /org/gnome/shell/extensions/openbar/ < "./dconf/openbar.dconf"
dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < "./dconf/shortcut-terminal.dconf"
