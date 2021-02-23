# Easier navigation: .., ..., ...., ....., ~ and -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Refresca .bashrc
alias refresh='source $HOME/.bashrc'

# Bare git repo alias para dotfiles
alias ds='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'	# para usar 'dot' enves de 'git' para el bare repository
alias dsa='ds add'	# comando rapido de add
alias dss='ds status'	# comando rapido de status 
alias dsc='ds commit -m'	# comando rapido de commit
alias dsp='ds_push'
function ds_push
    ds push origin main
    ds push glab main
end

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
alias vf='vifmrun'

# 'htop' enves de 'top'
alias top='htop'
alias nv='nvim'
alias cat='bat'
alias clear='clear; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo; echo'

    
# docker
alias dls='docker image ls'
alias dcs='docker ps -a'
