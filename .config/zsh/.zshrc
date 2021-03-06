# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.

[[ $(fgcosole 2> /dev/null) == 1 ]] && exec startx -- vt1 


HYPHEN_INSENSITIVE="true"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CACHE_HOME/zsh/history

setopt appendhistory
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS HIST_IGNORE_SPACE

setopt AUTO_CD

bindkey -v

autoload -Uz compinit && compinit

###### EXPORTS ######
source $ZDOTDIR/exports.sh

###### ALIASES ######
source $ZDOTDIR/aliases.sh

source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/joako/google-cloud-sdk/path.zsh.inc' ]; then . '/home/joako/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/joako/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/joako/google-cloud-sdk/completion.zsh.inc'; fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/joako/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/joako/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/joako/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/joako/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

colorscript -r
eval "$(starship init zsh)"
