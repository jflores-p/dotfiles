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

###### PROMPT ######
#source $ZDOTDIR/git_prompt.zsh
source $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh//.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

colorscript -r
