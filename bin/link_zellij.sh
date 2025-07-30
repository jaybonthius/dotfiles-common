#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
ZELLIJ_SOURCE="$DOTFILES_DIR/.config/zellij"
ZELLIJ_TARGET="$HOME/.config/zellij"

if [ ! -d "$ZELLIJ_SOURCE" ]; then
    echo "Error: Zellij config not found at $ZELLIJ_SOURCE"
    exit 1
fi

mkdir -p "$HOME/.config"

if [ -L "$ZELLIJ_TARGET" ]; then
    echo "Removing existing symlink: $ZELLIJ_TARGET"
    rm "$ZELLIJ_TARGET"
elif [ -d "$ZELLIJ_TARGET" ]; then
    echo "Backing up existing directory: $ZELLIJ_TARGET -> $ZELLIJ_TARGET.backup"
    mv "$ZELLIJ_TARGET" "$ZELLIJ_TARGET.backup"
elif [ -f "$ZELLIJ_TARGET" ]; then
    echo "Backing up existing file: $ZELLIJ_TARGET -> $ZELLIJ_TARGET.backup"
    mv "$ZELLIJ_TARGET" "$ZELLIJ_TARGET.backup"
fi

ln -s "$ZELLIJ_SOURCE" "$ZELLIJ_TARGET"
echo "Successfully linked $ZELLIJ_SOURCE -> $ZELLIJ_TARGET"