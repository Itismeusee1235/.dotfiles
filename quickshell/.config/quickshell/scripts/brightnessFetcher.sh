#!/usr/bin/env bash

get_brightness()
{
  brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'
}

get_icon()
{
  local bright=$(get_brightness)
  
  if [ "$bright" -ge 90 ]; then echo " "
  elif [ "$bright" -ge 80 ]; then echo " "
  elif [ "$bright" -ge 70 ]; then echo " "
  elif [ "$bright" -ge 60 ]; then echo " "
  elif [ "$bright" -ge 50 ]; then echo " "
  elif [ "$bright" -ge 40 ]; then echo " "
  elif [ "$bright" -ge 30 ]; then echo " "
  elif [ "$bright" -ge 20 ]; then echo " "
  else echo " "
  fi
}

jq -n -c --arg percent "$(get_brightness)" --arg icon "$(get_icon)" '{percent: $percent, icon: $icon}'
