# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.bash_{aliases,prompt,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

colorscript -r

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# *cd sin necesidad de escribir 'cd'
shopt -s autocd
