#!/bin/bash

if which nft &> /dev/null; then
  _log "info" "Configuring firewall..."

  sudo cp -f ./scripts/utils/firewall_rules /etc/nftables.conf  
  sudo systemctl enable --now nftables
fi
