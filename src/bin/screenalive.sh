#!/bin/bash

while true; do
    # xdotool key F9
    xdotool mousemove_relative --sync -- -1 0
    xdotool mousemove_relative 1 0
    sleep 60
done
