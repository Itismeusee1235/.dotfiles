#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/hypr-monitors.json"

listMonitors()
{
  hyprctl monitors -j | jq -r '.[].name'
}

get_info() {
  local display="$1"
  local mode="$2"   # pos | size | refresh | scale | mode | all

  case "$mode" in
    pos)
      hyprctl monitors -j \
        | jq -r ".[] | select(.name == \"$display\") | \"\(.x) \(.y)\""
      ;;

    size)
      hyprctl monitors -j \
        | jq -r ".[] | select(.name == \"$display\") | \"\(.width) \(.height)\""
      ;;

    refresh)
      hyprctl monitors -j \
        | jq -r ".[] | select(.name == \"$display\") | .refreshRate"
      ;;

    scale)
      hyprctl monitors -j \
        | jq -r ".[] | select(.name == \"$display\") | .scale"
      ;;

    mode)
      hyprctl monitors -j \
        | jq -r ".[] | select(.name == \"$display\") |
          \"\(.width)x\(.height)@\(.refreshRate)\""
      ;;

    all|*)
      hyprctl monitors -j \
        | jq -r ".[] | select(.name == \"$display\") |
          \"\(.x) \(.y) \(.width) \(.height) \(.refreshRate) \(.scale)\""
      ;;
  esac
}

list_modes() {
  local display="$1"

  hyprctl monitors -j \
    | jq -r ".[] | select(.name == \"$display\") | .availableModes[]"
}

get_position() {
  get_info "$1" pos
}

get_rel_position() {
  local display="$1"
  local base="eDP-1"

  read bx by < <(get_position "$base" )
  read x y < <(get_position "$display" )

  rx=$((x - bx))
  ry=$((y - by))

  dir=""

  if [ "$rx" -gt 0 ]; then
    dir+="right "
  elif [ "$rx" -lt 0 ]; then
    dir+="left "
  fi

  if [ "$ry" -gt 0 ]; then
    dir+="bottom "
  elif [ "$ry" -lt 0 ]; then
    dir+="top "
  fi

  echo "$dir"

}

get_size() {
  get_info "$1" size
}

move_workspaces() {
  
  local target="$1"

  for ws in $(hyprctl workspaces -j | jq -r '.[].id'); do
    hyprctl dispatch moveworkspacetomonitor "$ws" "$target"
  done
}

set_position() {
  display="$1"
  base="eDP-1"

  dir="$2"

  read bx by < <(get_position "$base")
  read bw bh < <(get_size "$base")
  read w h < <(get_size "$display")
  
  rx=$bx
  ry=$by

  if [ "$dir" = "left" ]; then
    rx=$((bx-w))
  elif [ "$dir" = "right" ]; then
    rx=$((bx+bw))
  elif [ "$dir" = "top" ]; then
    ry=$((by-h))
  elif [ "$dir" = "bottom" ]; then
    ry=$((by+bh))
  else
    {
      rx=$((bx-w))
    }
  fi
  
  mode=$(get_info "$display" mode)
  scale=$(get_info "$display" scale)

  hyprctl keyword monitor "$display,$mode,${rx}x${ry},$scale"
  qs ipc call TopBar forceReload 
}

set_mode() {

  display="$1"
  mode="$2"

  pos=$(get_info "$display" pos | awk '{print $1"x"$2}')
  scale=$(get_info "$display" scale)

  hyprctl keyword monitor "$display,$mode,$pos,$scale"
  qs ipc call TopBar forceReload 
}


save_config()
{
  local out="$STATE_FILE"
  hyprctl monitors -j | jq '
  map({
    name,
    mode: "\(.width)x\(.height)@\(.refreshRate)",
    pos: "\(.x)x\(.y)",
    scale
  })
  ' > "$out"
}

restore()
{
  local file="$STATE_FILE"

  if [ ! -f "$file" ]; then
    echo "No saved layout found"
    return 1
  fi

  jq -c '.[]' "$file" | while read -r m; do
    local name mode pos scale

    name=$(jq -r '.name' <<< "$m")
    mode=$(jq -r '.mode' <<< "$m")
    pos=$(jq -r '.pos' <<< "$m")
    scale=$(jq -r '.scale' <<< "$m")

    hyprctl keyword monitor "$name,$mode,$pos,$scale"
  done

  echo "Restored layout"
  qs ipc call TopBar forceReload 
}

restore



