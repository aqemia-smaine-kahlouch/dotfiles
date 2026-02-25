#!/bin/bash
set -eu

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Symlink config files
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/.config/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/.bash_aliases" ~/.bash_aliases

# Shell init: starship prompt + zoxide (cd replacement)
grep -q 'starship init bash' ~/.bashrc 2>/dev/null || echo 'eval "$(starship init bash)"' >> ~/.bashrc
grep -q 'zoxide init bash'  ~/.bashrc 2>/dev/null || echo 'eval "$(zoxide init bash --cmd cd)"' >> ~/.bashrc

# Source aliases if not already in .bashrc
grep -q '.bash_aliases' ~/.bashrc 2>/dev/null || echo '[ -f ~/.bash_aliases ] && . ~/.bash_aliases' >> ~/.bashrc

echo "Dotfiles installed successfully."
