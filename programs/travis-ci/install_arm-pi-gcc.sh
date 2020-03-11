#!/usr/bin/env bash

set -eu -o pipefail

echo "Installing Arm-pi"

if [[ -f $HOME/arm-pi/bin/arm-linux-gnueabihf-gcc ]]; then
    echo "Arm-pi FOUND in cache"
else
    echo "Arm-pi NOT FOUND in cache"
    target_path=$HOME/arm-pi
    target_url="https://sourceforge.net/projects/raspberry-pi-cross-compilers/files/Raspberry%20Pi%20GCC%20Cross-Compilers/GCC%208.3.0/Raspberry%20Pi%202%2C%203/cross-gcc-8.3.0-pi_2-3.tar.gz/download"
    mkdir -p "$target_path"
    curl -Ls "$target_url" | tar -xz -C "$target_path" --strip-components=1
fi

echo "Done installing Arm-pi"
