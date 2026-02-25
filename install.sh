#!/bin/bash
set -eu

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Install bash-it ---
if [ ! -d "$HOME/.bash_it" ]; then
    echo "Installing bash-it..."
    git clone --depth=1 https://github.com/Bash-it/bash-it.git "$HOME/.bash_it"
    "$HOME/.bash_it/install.sh" --silent --no-modify-config
fi

# --- Enable bash-it components ---
# Aliases
for a in bash-it directory editor general; do
    bash-it enable alias "$a" 2>/dev/null || true
done

# Plugins
bash-it enable plugin base 2>/dev/null || true

# Completions
for c in system bash-it docker git github-cli go terraform; do
    bash-it enable completion "$c" 2>/dev/null || true
done

# --- Symlink config files ---
mkdir -p ~/.config ~/.bash_it/custom ~/.bash_it/aliases

ln -sf "$DOTFILES_DIR/.config/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/custom/smana.bash" ~/.bash_it/custom/smana.bash
ln -sf "$DOTFILES_DIR/aliases/smana.bash" ~/.bash_it/aliases/smana.bash

# --- Ensure .bashrc loads bash-it ---
if ! grep -q 'BASH_IT' ~/.bashrc 2>/dev/null; then
    cat >> ~/.bashrc <<'BASHRC'

# bash-it
export BASH_IT="$HOME/.bash_it"
export BASH_IT_THEME='pure'
export SCM_CHECK=true
unset MAILCHECK
source "$BASH_IT/bash_it.sh"
BASHRC
fi

echo "Dotfiles installed successfully."
