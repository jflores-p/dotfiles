
setopt PROMPT_SUBST

autoload -U add-zsh-hook
autoload -Uz vcs_info

# Use True color (24-bit) if available.
if [[ "${terminfo[colors]}" -ge 256 ]]; then
    local_turquoise="%F{73}"
    local_orange="%F{179}"
    local_red="%F{167}"
    local_purple="%F{134}"
    local_green="%F{green}"
else
    local_turquoise="%F{cyan}"
    local_orange="%F{yellow}"
    local_red="%F{red}"
    local_purple="%F{green}"
fi

# Reset color.
local_reset_color="%f"

# VCS style formats.
FMT_UNCOMMITED="%{$local_reset_color%} %{$local_orange%}" 	# modificados sin hacer commit
FMT_STASHED="%{$local_reset_color%} %{$local_orange%}" 	# 
FMT_UNSTAGED="%{$local_reset_color%} %{$local_orange%}"	# nuevos (sin regristro previo)
FMT_STAGED="%{$local_reset_color%} %{$local_green%}✚" 		# agregados con add
FMT_ACTION="(%{$local_purple%}%a%{$local_reset_color%})"
FMT_VCS_STATUS=" on %{$local_turquoise%} %b%u%c%{$local_reset_color%}"

zstyle ':vcs_info:*' enable git svn #check-for-changes
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' unstagedstr    "${FMT_UNSTAGED}"
zstyle ':vcs_info:*' stagedstr      "${FMT_STAGED}"
zstyle ':vcs_info:*' actionformats  "${FMT_VCS_STATUS} ${FMT_ACTION}"
zstyle ':vcs_info:*' formats        "${FMT_VCS_STATUS}"
zstyle ':vcs_info:*' nvcsformats    ""
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Check for untracked files.
+vi-git-untracked() {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain | grep --max-count=1 '^??' &> /dev/null; then
            hook_com[staged]+="%{$local_reset_color%} %{$local_red%}●"
	fi
}


# Executed before each prompt.
add-zsh-hook precmd vcs_info

# Oxide prompt style.
PROMPT=$'%{%B$local_purple%} %~%{$local_reset_color%}%b'
PROMPT+=$'${vcs_info_msg_0_}'
PROMPT+=$'%(?.%{%F{white}%}.%{$local_red%})%(!.#.❯)%{$local_reset_color%} '


# prompt_git() {
#	local message=''
#	local state=''
#	local branch='';
#	if [[ ${PWD/#$HOME/~} == $HOME ]]; then
#		branch="$(/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME symbolic-ref --quiet --short HEAD 2> /dev/null || \
#			/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME describe --all --exact-match HEAD 2> /dev/null || \
#			/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME rev-parse --short HEAD 2> /dev/null || \
#			echo '(unknown)')"
#		if [ ! $(/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME diff --quiet --ignore-submodules --cached) ]; then
#				state+=$FMT_UNCOMMITED
#				fi;
#		# Check for unstaged changes. 	archivos modificados
#		if [ ! $(/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME diff-files --quiet --ignore-submodules --) ]; then
#			state+=$FMT_STAGED
#		fi;
#		# Check for untracked files. 	archivos nuevos
#		if [ -n "$(/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME ls-files --others --exclude-standard)" ]; then
#			state+=$FMT_UNTRACKED
#        	fi;
#	        # Check for stashed files. 	archibos escondidos?
#	        if [ $(/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME rev-parse --verify refs/stash &>/dev/null) ]; then
#			state+=$FMT_STASHED 
#	        fi;
#
#	elif [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]]; then
#		branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
#			git describe --all --exact-match HEAD 2> /dev/null || \
#			git rev-parse --short HEAD 2> /dev/null || \
#			echo '(unknown)')"
#		repoUrl="$(git config --get remote.origin.url)";
#		#if [ grep -q 'chromium/src.git' <<< "${repoUrl}" ]; then
#		#	state+='';
#		#else
#			# Check for uncommitted changes in the index.
#			if [ ! $(git diff --quiet --ignore-submodules --cached) ]; then
#				state+=$FMT_UNCOMMITED
#				fi;
#			# Check for unstaged changes. 	archivos modificados
#			if [ ! $(git diff-files --quiet --ignore-submodules --) ]; then
#				state+=$FMT_STAGED
#			fi;
#			# Check for untracked files. 	archivos nuevos
#			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
#				state+=$FMT_UNTRACKED
#        		fi;
#		        # Check for stashed files. 	archibos escondidos?
#		        if [ $(git rev-parse --verify refs/stash &>/dev/null) ]; then
#				state+=$FMT_STASHED
#		        fi;
#    		#fi;
#	fi
#
#	if [[ $branch ]]; then
#		message=" %{$local_turquoise%} ${branch}${state}"
#	fi
#
#
#	echo -e "${message}";
#}

#PROMPT='%{%B$local_purple%} %~%{$local_reset_color%}%b'
#ROMPT+='$local_reset_color'
#PROMPT+='$(prompt_git)'
#PROMPT+=' %F{cyan}%(!.#.❯)%{$local_reset_color%} '
