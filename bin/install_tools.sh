#!/bin/bash

echo "Installing tools"

# Exit on any error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Install zoxide
print_status "Installing zoxide..."
if ! command -v zoxide &> /dev/null; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    print_status "zoxide installed successfully"
else
    print_warning "zoxide already installed, skipping..."
fi

# Install fzf
print_status "Installing fzf..."
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    # ~/.fzf/install --all
    # TODO: this installs keybindings and updates shell, which we don't want
    # maybe this? 
    # ~/.fzf/install --key-bindings --completion --no-update-rc --no-zsh --no-fish
    print_status "fzf installed successfully"
else
    print_warning "fzf already installed, skipping..."
fi

# Install eza
print_status "Installing eza..."
if ! command -v eza &> /dev/null; then
    sudo apt update
    sudo apt install -y gpg
    
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
    print_status "eza installed successfully"
else
    print_warning "eza already installed, skipping..."
fi

# Install bat
print_status "Installing bat..."
if ! command -v bat &> /dev/null && [ ! -f "$HOME/.local/bin/bat" ]; then
    sudo apt install -y bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
    print_status "bat installed successfully"
else
    print_warning "bat already installed, skipping..."
fi

# # Install starship
# print_status "Installing starship..."
# if ! command -v starship &> /dev/null; then
#     curl -sS https://starship.rs/install.sh | sh
#     print_status "starship installed successfully"
# else
#     print_warning "starship already installed, skipping..."
# fi
