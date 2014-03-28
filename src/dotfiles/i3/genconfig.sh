#!/bin/bash
# 2a97bb32990944fbbb7b55058835b601

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HNANME=$(hostname)

bconf="$THIS_DIR/base-config"
hconf="$THIS_DIR/$HNANME-config"
tconf="$THIS_DIR/temp-config"

if [[ -f "$hconf" ]]; then
    cat "$bconf" > "$THIS_DIR/config"
    echo "" >> "$THIS_DIR/config"
    echo "#################" >> "$THIS_DIR/config"
    echo "# Include $hconf" >> "$THIS_DIR/config"
    echo "#################" >> "$THIS_DIR/config"
    echo "" >> "$THIS_DIR/config"
    cat "$hconf" >> "$THIS_DIR/config"
else
    cat "$bconf" > "$THIS_DIR/config"
fi

if [[ -f $tconf ]]; then
    cat "$tconf" >> "$THIS_DIR/config"
fi
