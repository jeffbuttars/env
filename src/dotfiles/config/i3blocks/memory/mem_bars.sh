#!/usr/bin/env bash

#free -w
#                total        used        free      shared     buffers       cache   available
# Mem:        65631996    44108184     4561104     4965212     1932700    20734040    21523812
# Swap:       72202676     1388012    70814664

SKY=#04a5e5
PEACH=#fe640b
GREEN=#40a02b
BLUE=#1e66f5
BAR=█
# RAM=🐏
CHIP=
INOUT=李
NUM_BARS=4

MEM_LINE=$(free -w | grep 'Mem: ')
SWAP_LINE=$(free -w | grep 'Swap: ')
# format = <label> <bar-used> 李<bar-swap-used>
# ; format-padding = 3
#
# label =  %percentage_used%%
# label-swap = 李 %percentage_swap_used%%

MEM_USED_PERC="$(echo "$MEM_LINE" | awk '{printf "%d", ($3/$2) * 100}')"
MEM_GREEN_BARS=$((MEM_USED_PERC / (100 / NUM_BARS)))
MEM_BLUE_BARS=$((NUM_BARS - MEM_GREEN_BARS))

for ((i = 0; i < MEM_GREEN_BARS; i++)); do
	MEM_BARS+="<span color=\"$GREEN\">$BAR</span>"
done
for ((i = 0; i < MEM_BLUE_BARS; i++)); do
	MEM_BARS+="<span color=\"$SKY\">$BAR</span>"
done

SWAP_USED_PERC="$(echo "$SWAP_LINE" | awk '{printf "%d", ($3/$2) * 100}')"
SWAP_GREEN_BARS=$((SWAP_USED_PERC / (100 / NUM_BARS)))
SWAP_BLUE_BARS=$((NUM_BARS - SWAP_GREEN_BARS))

for ((i = 0; i < SWAP_GREEN_BARS; i++)); do
	SWAP_BARS+="<span color=\"$GREEN\">$BAR</span>"
done
for ((i = 0; i < SWAP_BLUE_BARS; i++)); do
	SWAP_BARS+="<span color=\"$SKY\">$BAR</span>"
done

LONG_LINE="${CHIP} ${MEM_USED_PERC}% ${MEM_BARS} ${INOUT}${SWAP_BARS}"
SHORT_LINE="${CHIP}${MEM_USED_PERC}% ${INOUT}${SWAP_USED_PERC}%"

echo "$LONG_LINE"
echo "$SHORT_LINE"
