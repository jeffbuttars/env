#!/usr/bin/env bash

c=0
t=0
GREEN=#40a02b
PEACH=#fe640b
RED=#d20f39
BLUE=#1e66f5

awk '/MHz/ {print $4}' </proc/cpuinfo | (
	while read -r i; do
		t=$(echo "$t + $i" | bc)
		c=$((c + 1))
	done

	ghz=$(echo "scale=2; $t / $c / 1000" | bc | awk '{print $1}')

	# green
	color="$GREEN"

	if [[ $(echo "$ghz < 3.0" | bc -l) == "1" ]]; then
		# blue
		color="$BLUE"
	elif [[ $(echo "$ghz < 2.0" | bc -l) == "1" ]]; then
		# yellow
		color=$PEACH
	elif [[ $(echo "$ghz < 1.0" | bc -l) == "1" ]]; then
		# red
		color="$RED"
	fi

	# echo "%{F$color}${ghz}GHz${F-}"
	LINE="<span color='$color'>${ghz}GHz</span>"
	echo "$LINE"
	echo "$LINE"
)
