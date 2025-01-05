#!/bin/bash

if which docker &> /dev/null; then
  _log "info" "Configuring docker..."

  sudo systemctl enable docker
  sudo usermod -aG docker "$USER"
fi
