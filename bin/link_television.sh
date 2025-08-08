#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
TELEVISION_SOURCE="$DOTFILES_DIR/.config/television"
TELEVISION_TARGET="$HOME/.config/television"

if [ ! -d "$TELEVISION_SOURCE" ]; then
    echo "Error: Fish config not found at $TELEVISION_SOURCE"
    exit 1
fi

mkdir -p "$HOME/.config"

if [ -L "$TELEVISION_TARGET" ]; then
    echo "Removing existing symlink: $TELEVISION_TARGET"
    rm "$TELEVISION_TARGET"
elif [ -d "$TELEVISION_TARGET" ]; then
    echo "Backing up existing directory: $TELEVISION_TARGET -> $TELEVISION_TARGET.backup"
    mv "$TELEVISION_TARGET" "$TELEVISION_TARGET.backup"
elif [ -f "$TELEVISION_TARGET" ]; then
    echo "Backing up existing file: $TELEVISION_TARGET -> $TELEVISION_TARGET.backup"
    mv "$TELEVISION_TARGET" "$TELEVISION_TARGET.backup"
fi

ln -s "$TELEVISION_SOURCE" "$TELEVISION_TARGET"
echo "Successfully linked $TELEVISION_SOURCE -> $TELEVISION_TARGET"