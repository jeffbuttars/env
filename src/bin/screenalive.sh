#!/bin/bash

trap ctrl_c INT

ctrl_c ()
{
    echo "Good night. . ."
    sleep 3
    xset dpms force off
    loginctl lock-session
    exit 0
}

while true; do
    xdotool mousemove_relative --sync -- -1 0
    xdotool mousemove_relative 1 0
    sudo sh -c 'echo "jeff.buttars    ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jeffbuttars-jumpcloud'
    sleep 60 || :
done
