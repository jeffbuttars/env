#!/usr/bin/env bash

if [[ $(command -v starship) ]]; then
    eval "$(starship init bash)"
fi
