#!/usr/bin/env bash

set -eu -o pipefail

echo "Installing arm-none-eabi"

if [[ -f $HOME/arm-none-eabi/bin/arm-none-eabi-gcc ]]; then
    echo "Arm-none-eabi FOUND in cache"
else
    echo "Arm-none-eabi NOT FOUND in cache"
    target_path=$HOME/arm-none-eabi
    target_url="https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2?"
    mkdir -p "$target_path"
    curl -Ls "$target_url" | tar -xj -C "$target_path" --strip-components=1
fi

echo "Done installing Arm-none-eabi"
