#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
NVIM_SOURCE="$DOTFILES_DIR/.config/nvim"
NVIM_TARGET="$HOME/.config/nvim"

if [ ! -d "$NVIM_SOURCE" ]; then
    echo "Error: Nvim config not found at $NVIM_SOURCE"
    exit 1
fi

mkdir -p "$HOME/.config"

if [ -L "$NVIM_TARGET" ]; then
    echo "Removing existing symlink: $NVIM_TARGET"
    rm "$NVIM_TARGET"
elif [ -d "$NVIM_TARGET" ]; then
    echo "Backing up existing directory: $NVIM_TARGET -> $NVIM_TARGET.backup"
    mv "$NVIM_TARGET" "$NVIM_TARGET.backup"
elif [ -f "$NVIM_TARGET" ]; then
    echo "Backing up existing file: $NVIM_TARGET -> $NVIM_TARGET.backup"
    mv "$NVIM_TARGET" "$NVIM_TARGET.backup"
fi

ln -s "$NVIM_SOURCE" "$NVIM_TARGET"
echo "Successfully linked $NVIM_SOURCE -> $NVIM_TARGET"