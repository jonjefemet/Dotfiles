#!/bin/bash

update() {
  source "$CONFIG_DIR/icons.sh"
  INTERFACE="en0" # Cambia esto si tu interfaz WiFi no es en0
  WIFI_STATUS=$(networksetup -getairportnetwork $INTERFACE | grep "Current Wi-Fi Network" | awk -F ': ' '{print $2}')
  
  # Verificar si la salida contiene el nombre de la red
  if [ -n "$WIFI_STATUS" ]; then
      ICON="$WIFI_CONNECTED"
  else
    ICON="$WIFI_DISCONNECTED"
  fi  

  sketchybar --set $NAME icon="$ICON" label="$LABEL"
}

click() {
  CURRENT_WIDTH="$(sketchybar --query $NAME | jq -r .label.width)"

  WIDTH=0
  if [ "$CURRENT_WIDTH" -eq "0" ]; then
    WIDTH=dynamic
  fi

  sketchybar --animate sin 20 --set $NAME label.width="$WIDTH"
}

case "$SENDER" in
  "wifi_change") update
  ;;
  "mouse.clicked") click
  ;;
esac
