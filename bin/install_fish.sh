#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install fish
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo add-apt-repository ppa:fish-shell/release-4 -y
    sudo apt update
    sudo apt install fish -y
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi