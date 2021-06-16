#!/usr/bin/env bash

HNAME=$(hostname)

# Terminate already running bar instances
killall -q polybar

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
else
    echo "Using polybar config 'onescreen'"
    polybar --reload onescreen &
fi


echo "Bars launched..."
