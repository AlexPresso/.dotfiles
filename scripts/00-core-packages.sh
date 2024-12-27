#!/bin/bash

packages=(
  base base-devel git jq
)

if [[ "$v_update_packages" == "yes" ]]; then
  _log "info" "Updating packages..."
  sudo pacman -Syu --noconfirm
fi

_log "info" "Installing required packages..."
_pacman base base-devel git curl wget

_log "info" "Installing kernel headers..."
for kernel in $(cat /usr/lib/modules/*/pkgbase); do
  _pacman "${kernel}-headers"
done

if ! which "$v_package_manager" &> /dev/null; then
  _log "info" "Installing $v_package_manager package manager..."
  rm -rf "$inst_tmp_dir/$v_package_manager"
  git clone "https://aur.archlinux.org/$v_package_manager" "$inst_tmp_dir/$v_package_manager"
  (cd "$inst_tmp_dir/$v_package_manager" && makepkg -si --noconfirm 2>&1)
fi

_log "info" "Installing packages..."

v_additional_packages=$(echo "${v_additional_packages}" | tr '\n' ' ')
read -r -a v_additional_packages <<< "$v_additional_packages"
_aur_install \
  "${packages[@]}" \
  "${v_additional_packages[@]}" \
  "$v_terminal"
