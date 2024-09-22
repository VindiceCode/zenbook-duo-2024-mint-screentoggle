#!/bin/bash

# Function to get the names of the displays
get_displays() {
    xrandr | grep " connected" | cut -d " " -f1
}

# Function to check if a display is active
is_display_active() {
    xrandr --query | grep "^$1" | grep " connected" | grep -q " [0-9]"
}

# Function to identify the Zenbook Duo displays
identify_duo_displays() {
    local displays=("$@")
    local main_display=""
    local bottom_display=""
    
    for display in "${displays[@]}"; do
        if [[ "$display" == *"eDP"* ]]; then
            if [[ -z "$main_display" ]]; then
                main_display="$display"
            else
                bottom_display="$display"
            fi
        fi
    done
    
    echo "$main_display $bottom_display"
}

# Function to save current display configuration
save_display_config() {
    xrandr --current > /tmp/xrandr_config
}

# Function to restore display configuration
restore_display_config() {
    while read -r line; do
        if [[ $line == *" connected "* ]]; then
            display=$(echo $line | cut -d " " -f1)
            if [[ $line == *"primary"* ]]; then
                mode=$(echo $line | sed -n 's/.*primary \([0-9x]*\).*/\1/p')
                position=$(echo $line | sed -n 's/.*primary [0-9x]* \([0-9x+]*\).*/\1/p')
                xrandr --output $display --primary --mode $mode --pos $position
            elif [[ $line == *" [0-9]"* ]]; then
                mode=$(echo $line | sed -n 's/.* \([0-9x]*\).*/\1/p')
                position=$(echo $line | sed -n 's/.* [0-9x]* \([0-9x+]*\).*/\1/p')
                xrandr --output $display --mode $mode --pos $position
            fi
        fi
    done < /tmp/xrandr_config
}

# Get the names of all connected displays
DISPLAYS=($(get_displays))

# Identify the Zenbook Duo displays
read MAIN_DISPLAY BOTTOM_DISPLAY <<< $(identify_duo_displays "${DISPLAYS[@]}")

if [[ -z "$MAIN_DISPLAY" || -z "$BOTTOM_DISPLAY" ]]; then
    echo "Error: Could not identify Zenbook Duo displays"
    exit 1
fi

# Save current configuration
save_display_config

# Toggle the bottom display
if is_display_active "$BOTTOM_DISPLAY"; then
    echo "Turning off bottom display"
    xrandr --output "$BOTTOM_DISPLAY" --off
    echo "Bottom display should now be off"
else
    echo "Turning on bottom display"
    xrandr --output "$BOTTOM_DISPLAY" --auto --below "$MAIN_DISPLAY"
    echo "Bottom display should now be on"
fi

# Restore configuration for other displays
restore_display_config

# Ensure main display is set correctly
xrandr --output "$MAIN_DISPLAY" --auto --pos 0x0

# Display current status
echo "Current display status:"
xrandr --query | grep " connected"
