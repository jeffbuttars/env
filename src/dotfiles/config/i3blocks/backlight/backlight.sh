#!/usr/bin/env bash

SCREEN=
BAR_WIDTH=10
BAR_INDICATOR=
BAR_FILL=─

# Find all backlights
declare -a BACKLIGHTS
LONG_LINE=""
SHORT_LINE=""
ADJUST=""

# Did we get a click?
if [[ "$1" == "4" ]]; then
	ADJUST="up"
elif [[ "$1" == "5" ]]; then
	ADJUST="down"
fi

for blight in /sys/class/backlight/*; do
	BACKLIGHTS+=("$(basename "$blight")")
done

for blight in "${BACKLIGHTS[@]}"; do
	# echo "Backlight: ${blight}"
	MAX_BR=$(cat "/sys/class/backlight/${blight}/max_brightness")
	BR=$(cat "/sys/class/backlight/${blight}/brightness")

	if [[ -n "$ADJUST" ]]; then
		# Adjust the brightness first
		STEP=$((MAX_BR / 20))

		if [[ "$ADJUST" == "up" ]]; then
			VAL=$((BR + STEP))
		else
			VAL=$((BR - STEP))
		fi

		echo "$VAL" >"/sys/class/backlight/${blight}/brightness"
	fi

	BR_PERC=$(printf "%d\n" "$(echo "scale=3; ($BR / $MAX_BR) * 100" | bc -l)")
	BR_IDX=$((BR_PERC / 10))

	BAR=""
	for ((i = 0; i < BAR_WIDTH; i++)); do
		if [[ "$i" == "$BR_IDX" ]]; then
			BAR+="$BAR_INDICATOR"
		else
			BAR+="$BAR_FILL"
		fi
	done

	LONG_LINE+="${BR_PERC}% ${BAR} ${SCREEN} "
	SHORT_LINE+="${BR_PERC}% ${SCREEN} "
done

echo "$LONG_LINE"
echo "$SHORT_LINE"
