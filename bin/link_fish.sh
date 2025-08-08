#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
FISH_SOURCE="$DOTFILES_DIR/.config/fish"
FISH_TARGET="$HOME/.config/fish"

if [ ! -d "$FISH_SOURCE" ]; then
    echo "Error: Fish config not found at $FISH_SOURCE"
    exit 1
fi

mkdir -p "$HOME/.config"

if [ -L "$FISH_TARGET" ]; then
    echo "Removing existing symlink: $FISH_TARGET"
    rm "$FISH_TARGET"
elif [ -d "$FISH_TARGET" ]; then
    echo "Backing up existing directory: $FISH_TARGET -> $FISH_TARGET.backup"
    mv "$FISH_TARGET" "$FISH_TARGET.backup"
elif [ -f "$FISH_TARGET" ]; then
    echo "Backing up existing file: $FISH_TARGET -> $FISH_TARGET.backup"
    mv "$FISH_TARGET" "$FISH_TARGET.backup"
fi

ln -s "$FISH_SOURCE" "$FISH_TARGET"
echo "Successfully linked $FISH_SOURCE -> $FISH_TARGET"