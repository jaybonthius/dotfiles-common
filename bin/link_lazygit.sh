#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
LAZYGIT_SOURCE="$DOTFILES_DIR/.config/lazygit"
LAZYGIT_TARGET="$HOME/.config/lazygit"

if [ ! -d "$LAZYGIT_SOURCE" ]; then
    echo "Error: Lazygit config not found at $LAZYGIT_SOURCE"
    exit 1
fi

mkdir -p "$HOME/.config"

if [ -L "$LAZYGIT_TARGET" ]; then
    echo "Removing existing symlink: $LAZYGIT_TARGET"
    rm "$LAZYGIT_TARGET"
elif [ -d "$LAZYGIT_TARGET" ]; then
    echo "Backing up existing directory: $LAZYGIT_TARGET -> $LAZYGIT_TARGET.backup"
    mv "$LAZYGIT_TARGET" "$LAZYGIT_TARGET.backup"
elif [ -f "$LAZYGIT_TARGET" ]; then
    echo "Backing up existing file: $LAZYGIT_TARGET -> $LAZYGIT_TARGET.backup"
    mv "$LAZYGIT_TARGET" "$LAZYGIT_TARGET.backup"
fi

ln -s "$LAZYGIT_SOURCE" "$LAZYGIT_TARGET"
echo "Successfully linked $LAZYGIT_SOURCE -> $LAZYGIT_TARGET"