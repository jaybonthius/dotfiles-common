#!/bin/bash

echo "Setting up Zsh with Oh My Zsh and essential tools..."

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

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    print_error "Zsh is not installed. Please install it first with: sudo apt install zsh"
    exit 1
fi

# Install Oh My Zsh
print_status "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_status "Oh My Zsh installed successfully"
else
    print_warning "Oh My Zsh already installed, skipping..."
fi

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
    ~/.fzf/install --all
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

# Install starship
print_status "Installing starship..."
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh
    print_status "starship installed successfully"
else
    print_warning "starship already installed, skipping..."
fi

# Install zsh-syntax-highlighting plugin
print_status "Installing zsh-syntax-highlighting plugin..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    print_status "zsh-syntax-highlighting installed successfully"
else
    rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    print_status "zsh-syntax-highlighting reinstalled successfully"
fi

# Install zsh-autosuggestions plugin
print_status "Installing zsh-autosuggestions plugin..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    print_status "zsh-autosuggestions installed successfully"
else
    rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    print_status "zsh-autosuggestions reinstalled successfully"
fi

# Setup .zshrc symlink
print_status "Setting up .zshrc symlink..."

# Backup existing .zshrc if it exists and isn't already a symlink
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    print_warning "Backing up existing .zshrc to .zshrc.backup"
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# Remove existing symlink if it exists
[ -L "$HOME/.zshrc" ] && rm "$HOME/.zshrc"

# Create symlink
ln -s "$(dirname "$0")/../.zshrc" "$HOME/.zshrc"
print_status ".zshrc symlink created: ~/.zshrc -> $(dirname "$0")/../.zshrc"

print_status "Zsh setup completed successfully!"
echo ""
print_warning "Don't forget to:"
echo "  1. Change your default shell to zsh:"
echo "     chsh -s \$(which zsh)"
echo "  2. Restart your terminal or run: source ~/.zshrc"