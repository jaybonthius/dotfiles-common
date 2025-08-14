echo "Helix config files linked to $HELIX_CONFIG_TARGET"
#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
HELIX_SOURCE="$DOTFILES_DIR/.config/helix"
HELIX_TARGET="$HOME/.config/helix"

if [ ! -d "$HELIX_SOURCE" ]; then
  echo "Error: Helix config not found at $HELIX_SOURCE"
  exit 1
fi

mkdir -p "$HOME/.config"

if [ -L "$HELIX_TARGET" ]; then
  echo "Removing existing symlink: $HELIX_TARGET"
  rm "$HELIX_TARGET"
elif [ -d "$HELIX_TARGET" ]; then
  echo "Backing up existing directory: $HELIX_TARGET -> $HELIX_TARGET.backup"
  mv "$HELIX_TARGET" "$HELIX_TARGET.backup"
elif [ -f "$HELIX_TARGET" ]; then
  echo "Backing up existing file: $HELIX_TARGET -> $HELIX_TARGET.backup"
  mv "$HELIX_TARGET" "$HELIX_TARGET.backup"
fi

ln -s "$HELIX_SOURCE" "$HELIX_TARGET"
echo "Successfully linked $HELIX_SOURCE -> $HELIX_TARGET"
