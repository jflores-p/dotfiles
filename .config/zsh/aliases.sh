# Easier navigation: .., ..., ...., ....., ~ and -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~' # `cd` is probably faster to type though
alias -- -='cd -'

# Get week number
alias week='date +%V'

# Refresca .bashrc
alias refresh='source $HOME/.bashrc'

# Bare git repo alias para dotfiles
alias ds='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'	# para usar 'dot' enves de 'git' para el bare repository
alias dsa='ds add'	# comando rapido de add
alias dss='ds status'	# comando rapido de status 
alias dsc='ds commit -m'	# comando rapido de commit
alias dsp='g'
g(){
    ds push origin main
    ds push glab main
}

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

# switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# adding flags
alias cp='cp -i'                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
# alias vf='source ~/.config/vifm/scripts/vifmrun'
alias vf='vifmrun'

# 'htop' enves de 'top'
alias top='htop'

alias nv='nvim'
    
# docker
alias dls='docker image ls'
alias dcs='docker ps -a'

# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Installation_and_recovery
f(){
    pacman -Qqetn > $HOME/.config/scripts/pkgs_lists/pacman;
    echo pacman
    pacman -Qqem > $HOME/.config/scripts/pkgs_lists/yay;
    echo yay
}

alias pkglist='f'
