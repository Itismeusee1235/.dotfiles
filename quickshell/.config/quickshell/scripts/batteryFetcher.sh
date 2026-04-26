#!/usr/bin/env bash

get_battery_percent(){
  LC_ALL=C cat /sys/class/power_supply/BAT0/capacity 2> /dev/null | head -n1 || echo "100"
}

get_battery_status(){
  LC_ALL=C cat /sys/class/power_supply/BAT0/status 2> /dev/null | head -n1 || echo "Charging"
}

get_battery_icon()
{
  local percent=$(get_battery_percent)
  local status=$(get_battery_status)

  if [ "$status" == "Charging" ] || [ "$status" == "Full" ]; then
    if [ "$percent" -ge 90 ]; then echo "󰂅 "
    elif [ "$percent" -ge 80 ]; then echo "󰂊 "
    elif [ "$percent" -ge 60 ]; then echo "󰂉 "
    elif [ "$percent" -ge 40 ]; then echo "󰂈 "
    else echo "󰂆 ";
    fi
  else
    if [ "$percent" -ge 90 ]; then echo "󰁹 "
    elif [ "$percent" -ge 80 ]; then echo "󰂁 "
    elif [ "$percent" -ge 60 ]; then echo "󰁿 "
    elif [ "$percent" -ge 40 ]; then echo "󰁽 "
    else echo "󰁻 ";
    fi
  fi
}

jq -n -c --arg percent "$(get_battery_percent)" --arg status "$(get_battery_status)" --arg icon "$(get_battery_icon)" '{percent: $percent, status: $status, icon: $icon}'
