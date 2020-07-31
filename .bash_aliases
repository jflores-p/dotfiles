#!/usr/bin/env bash

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~' # `cd` is probably faster to type though
alias -- -='cd -'

# Get week number
alias week='date +%V'

# Get general update
alias update='sudo pacman -Syu'

# Refresca .bashrc
alias refresh='source $HOME/.bashrc'

# Bare git repo alias para dotfiles
alias do='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'	# para usar 'dot' enves de 'git' para el bare repository
alias doa='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME add'	# comando rapido de add
alias dos='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME status'	# comando rapido de status 
alias doc='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME commit -m'	# comando rapido de commit

# Cambio de 'ls' a 'exa'
alias ls='exa -al@ --color=always --group-directories-first'	# long-view -- allfiles
alias la='exa -a --color=always --group-directories-first'	# allfiles
alias ll='exa -l --color=always --group-directories-first'	# long-view

# 'htop' enves de 'top'
alias top='htop'

alias nv='nvim'