#!/bin/bash

c=0
t=0

awk '/MHz/ {print $4}' </proc/cpuinfo | (
	while read -r i; do
		t=$(echo "$t + $i" | bc)
		c=$((c + 1))
	done

  ghz=$(echo "scale=2; $t / $c / 1000" | bc | awk '{print $1}')

  # green
  color="#40a02b"

  if [[ $(echo "$ghz < 3.0" | bc -l) == "1" ]]; then
    # blue
    color='#1e66f5'
  elif [[ $(echo "$ghz < 2.0" | bc -l) == "1" ]]; then
    # yellow
    color='#df8e1d'
  elif [[ $(echo "$ghz < 1.0" | bc -l) == "1" ]]; then
    # red
    color='#d20f39'
  fi

  echo "%{F$color}${ghz}GHz${F-}"
)
