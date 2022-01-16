#!/usr/bin/env bash

HNAME=$(hostname)
CONNECTED_SCREENS=$(xrandr | grep ' connected ' | awk '{print $1}')
DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

polybar --reload main -c "$DIR"/base/config.ini &
exit 0

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "Launching polybar for $HNAME"

if [[ "$HNAME" == "rose" ]]; then
    # Launch bar1 and bar2
    polybar --reload right &
    polybar --reload middle &
    polybar --reload left &
elif [[ "$HNAME" == "dvj-bst-dev-0011-buttars" ]]; then
    # Launch bar1 and bar2
    polybar --reload right &
    polybar --reload middle &
    polybar --reload left &
elif [[ "$HNAME" == "lola" ]]; then
    # Launch bar1 and bar2
    polybar --reload right &
    polybar --reload middle &
    polybar --reload left &
elif [[ "$HNAME" == "ephi" ]]; then
    polybar --reload ephi-left &
    polybar --reload ephi-middle &
elif [[ "$HNAME" == "chica" ]]; then
    left_display="DP-4"
    middle_display="DP-3-3"
    right_display="eDP-1"

    left_screen=""
    middle_screen=""
    right_screen=""

    # See what's attached and launch bars accordingly
    sa=($CONNECTED_SCREENS)
    [[ ${sa[*]} =~ "$left_display" ]] && left_screen="true" || left_screen=""
    [[ ${sa[*]} =~ "$right_display" ]] && right_screen="true" || right_screen=""

    echo "Screens found: $sa"

    if [[ $left_screen ]] &&  [[ $right_screen ]] ; then
        echo "Loading multi monitor config..."
        polybar --reload chica-left &
        polybar --reload chica-middle &
        polybar --reload chica-right &
    else
        echo "Loading single monitor config..."
        polybar --reload onescreen &
    fi
else
    echo "Using polybar config 'onescreen'"
    polybar --reload onescreen &
fi


echo "Bars launched..."
