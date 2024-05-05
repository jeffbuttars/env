#!/usr/bin/env bash

CPU_ZONE='x86_pkg_temp'
TYPE_NAME=''
ZONE=''
TEMP=''
GREEN=#40a02b
TEXT=#4c4f69
SUBTEXT0=#6c6f85
PEACH=#fe640b
MAROON=#e64553
RED=#d20f39

ramp_coreload_1=▁
ramp_color_1=$SUBTEXT0

ramp_coreload_2=▂
ramp_color_2=$SUBTEXT0

ramp_coreload_3=▄
ramp_color_3=$SUBTEXT0

ramp_coreload_4=▅
ramp_color_4=$GREEN

ramp_coreload_5=▅
ramp_color_5=$GREEN

ramp_coreload_6=▆
ramp_color_6=$PEACH

ramp_coreload_7=▇
ramp_color_7=$PEACH

ramp_coreload_8=▇
ramp_color_8=$MAROON

ramp_coreload_9=█
ramp_color_9=$MAROON

ramp_coreload_10=█
ramp_color_10=$RED

if [[ ! -d /sys/class/thermal ]]; then
	echo "N/A"
	exit
fi

for ttype in /sys/class/thermal/thermal_zone*/type; do
	TYPE_NAME=$(cat "$ttype")

	if [[ "$TYPE_NAME" == "$CPU_ZONE" ]]; then
		ZONE="$(basename "$(dirname "$ttype")")"
		TEMP=$(cat "/sys/class/thermal/${ZONE}/temp")
		break
	fi

	continue
done

if [[ -z $TEMP ]]; then
	echo "N/A"
	exit
fi
TEMP=$((TEMP / 1000))

RAMP=$(echo "$TEMP / 10" | bc)
RAMP_BAR=$(eval echo "\$ramp_coreload_${RAMP}")
RAMP_COLOR=$(eval echo "\$ramp_color_${RAMP}")

echo " $RAMP_BAR $TEMP°C"
echo " $TEMP°C"
echo "$RAMP_COLOR"
