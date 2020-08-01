# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CACHE_HOME/zsh/history
setopt appendhistory
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS HIST_IGNORE_SPACE


###### EXPORTS ######
source $ZDOTDIR/exports.zsh

###### ALIASES ######
source $ZDOTDIR/aliases.zsh


###### PROMPT ######
source $ZDOTDIR/oxide_prompt.zsh


colorscript -r
