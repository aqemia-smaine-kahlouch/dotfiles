#!/usr/bin/env bash

# Starship prompt
eval "$(starship init bash)"

# Zoxide (cd replacement)
eval "$(zoxide init --cmd cd bash)"

# History settings
export HISTSIZE=2000000
export HISTFILESIZE=3000000
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="%d/%m/%Y - %H:%M:%S > "
export HISTIGNORE="&:bg:fg:ll:"

export EDITOR=vim
export KUBE_EDITOR=vim

# AWS CLI completer (installed in workspace image)
complete -C /usr/local/bin/aws_completer aws 2>/dev/null

# Go
GOPATH=${HOME}/go
PATH=${PATH}:${GOPATH}/bin

# Cargo (Rust)
export PATH=$PATH:$HOME/.cargo/bin

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Custom aliases
source ~/.bash_it/aliases/smana.bash

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Terragrunt cache
export TF_PLUGIN_CACHE_DIR=$HOME/.terraform.d/plugin-cache
export TG_PROVIDER_CACHE=true
