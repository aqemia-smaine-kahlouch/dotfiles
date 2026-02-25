#!/bin/bash
set -eu

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Install bash-it ---
if [ ! -d "$HOME/.bash_it" ]; then
    echo "Installing bash-it..."
    git clone --depth=1 https://github.com/Bash-it/bash-it.git "$HOME/.bash_it"
fi

# --- Enable bash-it components via symlinks ---
mkdir -p "$HOME/.bash_it/enabled"

# Aliases
for a in bash-it directory editor general; do
    ln -sf "$HOME/.bash_it/aliases/available/${a}.aliases.bash" \
           "$HOME/.bash_it/enabled/150---${a}.aliases.bash" 2>/dev/null || true
done

# Plugins
ln -sf "$HOME/.bash_it/plugins/available/base.plugin.bash" \
       "$HOME/.bash_it/enabled/250---base.plugin.bash"

# Completions
for c in system bash-it docker git github-cli go terraform; do
    ln -sf "$HOME/.bash_it/completion/available/${c}.completion.bash" \
           "$HOME/.bash_it/enabled/350---${c}.completion.bash" 2>/dev/null || true
done
ln -sf "$HOME/.bash_it/completion/available/system.completion.bash" \
       "$HOME/.bash_it/enabled/325---system.completion.bash"
ln -sf "$HOME/.bash_it/completion/available/aliases.completion.bash" \
       "$HOME/.bash_it/enabled/800---aliases.completion.bash"

# --- Symlink config files ---
mkdir -p ~/.config ~/.bash_it/custom ~/.bash_it/aliases

ln -sf "$DOTFILES_DIR/.config/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/custom/smana.bash" ~/.bash_it/custom/smana.bash
ln -sf "$DOTFILES_DIR/aliases/smana.bash" ~/.bash_it/aliases/smana.bash

# --- Ensure .bash_profile sources .bashrc (login shells) ---
ln -sf "$DOTFILES_DIR/.bash_profile" ~/.bash_profile

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
