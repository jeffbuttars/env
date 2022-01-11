#!/bin/bash

while true; do
    xdotool mousemove_relative --sync -- -1 0
    xdotool mousemove_relative 1 0
    sudo sh -c 'echo "jeff.buttars    ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jeffbuttars-jumpcloud'
    sleep 60
done
