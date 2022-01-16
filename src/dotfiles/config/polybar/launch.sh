#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "Launching polybar for $HNAME"


HNAME=$(hostname)
CONNECTED_SCREENS=$(xrandr | grep ' connected ' | awk '{print $1}')
CONNECTED_SCREENS_INFO=$(xrandr | grep ' connected ' | awk '{print $3}')

CS=($CONNECTED_SCREENS)
echo "CONNECTED_SCREENS: ${CS[@]}"

CSI=($CONNECTED_SCREENS_INFO)
echo "CONNECTED_SCREENS_INFO: ${CSI[@]}"

NUM_SCREENS=${#CS[@]}

PRIMARY_DISPLAY=""
SECONDARY_DISPLAYS=""

if [[ $NUM_SCREENS -ge 1 ]]; then
    echo "Multiple displays: ${CS[@]}"

    for i in ${!CS[@]}; do
        if [[ "${CSI[$i]}" == "primary" ]]; then
            PRIMARY_DISPLAY="${CS[$i]}"
        else
            SECONDARY_DISPLAYS="$SECONDARY_DISPLAYS ${CS[$i]}"
        fi
    done
fi

echo ""
echo "primary_display: $PRIMARY_DISPLAY"
echo "secondary_displays: $SECONDARY_DISPLAYS"

DIR="$HOME/.config/polybar"

export POLYBAR_WLAN=
export POLYBAR_LAN=
export PRIMARY_MONITOR=
export SECONDARY_MONITOR=


if [[ "$HNAME" == "DVJ-BST-Dev-0020-ButtarsLT" ]]; then
    # BST Laptop
    export POLYBAR_WLAN=wlp0s20f3
    export POLYBAR_LAN=enp0s31f6
elif [[ "$HNAME" == "dvj-bst-dev-0011-buttars" ]]; then
    # BST Workstation
    export POLYBAR_WLAN=
    export POLYBAR_LAN=eno2
elif [[ "$HNAME" == "ephi" ]]; then
    export POLYBAR_WLAN=wlp3s0
    export POLYBAR_LAN=enp0s31f6
elif [[ "$HNAME" == "chica" ]]; then
    export POLYBAR_WLAN=wlp170s0
    export POLYBAR_LAN=enp0s13f0u3u1
fi

export PRIMARY_MONITOR="$PRIMARY_DISPLAY"
echo "PRIMARY_MONITOR=$PRIMARY_DISPLAY"
polybar --reload primary -c "$DIR"/base/config.ini &

if [[ $SECONDARY_DISPLAYS ]]; then
    for sec_mon in $SECONDARY_DISPLAYS ; do
        export SECONDARY_MONITOR="$sec_mon"
        echo "SECONDARY_MONITOR=$SECONDARY_MONITOR"
        polybar --reload secondary -c "$DIR"/base/config.ini &
    done
fi


echo "Bars launched..."
