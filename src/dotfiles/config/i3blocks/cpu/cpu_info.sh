#!/usr/bin/env bash

declare -a PREV_IDLES
declare -a PREV_TOTALS

declare -a CUR_IDLES
declare -a CUR_TOTALS

SCHED_HZ=100
RAMP_INTERVAL=14.28
LONG_LINE=""

GREEN=#40a02b
TEXT=#4c4f69
SUBTEXT0=#6c6f85
PEACH=#fe640b
MAROON=#e64553
RED=#d20f39

ramp_coreload_0=▁
ramp_color_0=$SUBTEXT0

ramp_coreload_1=▂
ramp_color_1=$SUBTEXT0

ramp_coreload_2=▃
ramp_color_2=$GREEN

ramp_coreload_3=▄
ramp_color_3=$GREEN

ramp_coreload_4=▅
ramp_color_4=$PEACH

ramp_coreload_5=▆
ramp_color_5=$PEACH

ramp_coreload_6=▇
ramp_color_6=$MAROON

ramp_coreload_7=█
ramp_color_7=$RED

#      user     nice     system   idle     iowait  irq     softirq steal  guest
# cpu[N]  87172326 1866562 18318019 970706787 2452934 4471640 2169214 0      0     0

# Each core
#grep -E '^cpu[[:digit:]]+' /proc/stat
#
# All cores composite
#grep -E '^cpu ' /proc/stat

idx=0
while read -r CORE_LINE; do
	PREV_IDLES[idx]=$(echo "$CORE_LINE" | awk -v RS="" '{printf "%d", $5}')
	PREV_TOTALS[idx]=$(echo "$CORE_LINE" | awk -v RS="" '{printf "%d", ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11)}')
	((idx++))
done <<<"$(grep -E '^cpu[[:digit:]]+' /proc/stat)"

sleep 0.01

idx=0
while read -r CORE_LINE; do
	CUR_IDLES[idx]=$(echo "$CORE_LINE" | awk -v RS="" '{printf "%d", $5}')
	CUR_TOTALS[idx]=$(echo "$CORE_LINE" | awk -v RS="" '{printf "%d", ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11)}')
	((idx++))
done <<<"$(grep -E '^cpu[[:digit:]]+' /proc/stat)"

idx=0
for prev_idle in "${PREV_IDLES[@]}"; do
	cur_idle=${CUR_IDLES[$idx]}
	prev_total=${PREV_TOTALS[$idx]}
	cur_total=${CUR_TOTALS[$idx]}
	diff=$((cur_total - prev_total))
	usage=$(echo "$diff $prev_idle $cur_idle $SCHED_HZ" | awk '{printf "%.2f", ((($1 - ($3 - $2)) / $1) * $4)}')

	ramp=$(echo "$usage / $RAMP_INTERVAL" | bc)
	bar=$(eval echo "\$ramp_coreload_${ramp}")
	color=$(eval echo "\$ramp_color_${ramp}")
	segment="<span color=\"${color}\">${bar}</span>"

	LONG_LINE="${LONG_LINE}$segment"

	((idx++))
done

#      user     nice     system   idle     iowait  irq     softirq steal  guest
# cpu  87172326 1866562 18318019 970706787 2452934 4471640 2169214 0      0     0

# Get the composite temp and use it to create the short line
COMP_LINE=$(grep '^cpu ' /proc/stat)
PREV_IDLE=$(echo "$COMP_LINE" | awk -v RS="" '{printf "%i", $5}')
PREV_TOTAL=$(echo "$COMP_LINE" | awk -v RS="" '{printf "%i", ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11)}')

sleep 0.01

COMP_LINE=$(grep '^cpu ' /proc/stat)
IDLE=$(echo "$COMP_LINE" | awk -v RS="" '{printf "%i", $5}')
TOTAL=$(echo "$COMP_LINE" | awk -v RS="" '{printf "%i", ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11)}')

COMP_DIFF=$((TOTAL - PREV_TOTAL))
COMP_CPU_USAGE=$(echo "$COMP_DIFF $PREV_IDLE $IDLE $SCHED_HZ" | awk '{printf "%d", ((($1 - ($3 - $2)) / $1) * $4)}')

COMP_RAMP=$(echo "$COMP_CPU_USAGE / $RAMP_INTERVAL" | bc)
COMP_BAR=$(eval echo "\$ramp_coreload_${COMP_RAMP}")
COMP_COLOR=$(eval echo "\$ramp_color_${COMP_RAMP}")

SHORT_LINE="$COMP_BAR $COMP_CPU_USAGE%"

echo "$LONG_LINE $COMP_CPU_USAGE%"
echo "$SHORT_LINE"
echo "$COMP_COLOR"
