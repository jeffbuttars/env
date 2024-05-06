#!/bin/sh
#
GREEN=#40a02b
TEXT=#4c4f69
SUBTEXT0=#6c6f85
PEACH=#fe640b
MAROON=#e64553
RED=#d20f39

# If ACPI was not installed, this probably is a battery-less computer.
ACPI_RES=$(acpi -b)
ACPI_CODE=$?
if [ $ACPI_CODE -eq 0 ]; then
	# Get essential information. Due to some bug with some versions of acpi it is
	# worth filtering the ACPI result from all lines containing "unavailable".
	BAT_LEVEL_ALL=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9][0-9]?[0-9]?%")
	BAT_LEVEL=$(echo "$BAT_LEVEL_ALL" | awk -F"%" 'BEGIN{tot=0;i=0} {i++; tot+=$1} END{printf("%d%%\n", tot/i)}')
	TIME_LEFT=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9]{2}:[0-9]{2}:[0-9]{2}")
	IS_CHARGING=$(echo "$ACPI_RES" | grep -v "unavailable" | awk '{ printf("%s\n", substr($3, 0, length($3)-1) ) }')

	# If there is no 'time left' information (when almost fully charged) we
	# provide information ourselves.
	# if [ -z "$TIME_LEFT" ]; then
	# 	TIME_LEFT="00:00:00"
	# fi

	BAT_ICON="🔋"
	if [ "$IS_CHARGING" = "Charging" ]; then
		BAT_ICON=""
	fi

	if [ "$BAT_LEVEL" = "100%" ]; then
		BAT_ICON=""
    TIME_LEFT=""
	fi

	if [[ -n "$TIME_LEFT" ]]; then
		TIME_LEFT=$(echo $TIME_LEFT | awk '{ printf("%s\n", substr($1, 0, 5)) }')
		TIME_LEFT="⏳$TIME_LEFT"
	fi

	echo "$BAT_ICON$BAT_LEVEL $TIME_LEFT"

	# Print the short text.
	echo "$BAT_ICON $BAT_LEVEL"

	# Change the font color, depending on the situation.
	if [ "$IS_CHARGING" = "Charging" ]; then
		# Charging yellow color.
		echo "$PEACH"
	else
		if [ "${BAT_LEVEL%?}" -le 15 ]; then
			# Battery very low. Red color.
			echo "$RED"
		else
			# Battery not charging but at decent level. Green color.
			echo "$TEXT"
		fi
	fi
fi
