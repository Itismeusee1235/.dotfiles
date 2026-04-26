#!/usr/bin/env bash

get_volume()
{
  local vol=""
  vol=$(LC_ALL=C wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2*100)}')
  echo "${vol:-0}"
}

get_muted()
{
  if LC_ALL=C wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q "MUTED"; then echo "true"; else echo "false"; fi
  
}

get_icon()
{
  local vol=$(get_volume)
  local muted=$(get_muted)

  if [ "$muted" = "false" ]; then
    if [ "$vol" -ge 66 ]; then echo "󰕾 "
    elif [ "$vol" -ge 33 ]; then echo "󰖀 "
    else echo "󰖀 "
    fi
  else 
    echo "󰖁 "
  fi
}

toggle_muted()
{
  LC_ALL=C wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

  if [ "$(get_muted)" = "true" ]; then notify-send -u low -i audio-volume-muted "Volume Muted"
  else notify-send -u low audio-volume-hgih "Volume Unmuted ($(get-volume))"
  fi
}


case $1 in 
  --toggle) toggle_muted;;
  *) jq -n -c --arg volume "$(get_volume)" --arg icon "$(get_icon)" --arg is_muted "$(get_muted)" '{volume: $volume, icon: $icon, is_muted: $is_muted}'

  esac

