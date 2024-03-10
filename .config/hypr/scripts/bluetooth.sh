#!/bin/bash

get_status() {
  bluetoothctl info | grep "Powered: yes" > /dev/null \
    && echo "on" \
    || echo "off"
}

switch_status() {
  if [ "$(get_status)" == "on" ]; then
    status="off"
  else
    status="on"
  fi

  bluetoothctl power "$status"
}

case "$1" in
  "--get") get_status ;;
  "--switch") switch_status ;;
  *) get_status ;;
esac
