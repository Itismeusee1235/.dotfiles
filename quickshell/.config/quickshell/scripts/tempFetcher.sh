#!/usr/bin/env bash

SENSOR="/sys/class/hwmon/hwmon6/temp1_input"

temp=$(cat "$SENSOR")
echo "$((temp / 1000))°C"
