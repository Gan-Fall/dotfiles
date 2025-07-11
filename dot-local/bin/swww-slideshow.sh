#!/bin/bash
# Credit for script to bnema: https://github.com/bnema
# Source: https://gist.github.com/bnema/20f68930ca2ba46a742ae0c593cfbb31 (if link doesn't work look for swww_random.sh)

# Variables
# INTERVAL=$((RANDOM % 1201 + 600))
INTERVAL=30
TRANSITION_STEP=2
TRANSITION_FPS=60

# Function to check if Steam is running
is_steam_running() {
    pgrep -x "steam" > /dev/null
    return $?
}

# Function to check if any window is fullscreen
is_any_window_fullscreen() {
    if hyprctl clients | grep -q "fullscreen: 1"; then
        return 0
    else
        return 1
    fi
}

# Fetch connected outputs using hyprctl monitors
outputs=$(hyprctl monitors | grep 'Monitor' | awk '{print $2}')

# Array of available transition types
transition_types=("wipe" "top" "left" "right" "bottom" "outer" "center" "simple")

# Define your screens output based on the connected outputs (hyprctl monitors)
declare -a screens=($outputs)

# Function to set wallpaper for a given screen
set_wallpaper() {
    local screen=$1
    echo "Chosen interval: $INTERVAL seconds"
    local ANGLE=$((RANDOM % 360))
    local TRANSITION_TYPE=${transition_types[$RANDOM % ${#transition_types[@]}]}

    while true; do   
        if ! is_steam_running && ! is_any_window_fullscreen; then
            img=$(find "$2" | shuf -n 1)
            if [[ "$TRANSITION_TYPE" == "wipe" ]]; then
                swww img -o "$screen" "$img" --transition-type $TRANSITION_TYPE --transition-step $TRANSITION_STEP --transition-angle $ANGLE --transition-fps $TRANSITION_FPS
            else
                swww img -o "$screen" "$img" --transition-type $TRANSITION_TYPE --transition-step $TRANSITION_STEP --transition-fps $TRANSITION_FPS
            fi
        fi
        sleep $INTERVAL
    done
}

# Call the set_wallpaper function for each screen
for screen in "${screens[@]}"; do
    set_wallpaper "$screen" "$1" &
done

# Keep the script running
while true; do sleep 86400; done
