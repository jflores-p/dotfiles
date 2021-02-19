
source $HOME/.config/fish/functions.fish

source $HOME/.config/fish/exports.fish

source $HOME/.config/fish/aliases.fish

colorscript random

starship init fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/joako/google-cloud-sdk/path.fish.inc' ]; . '/home/joako/google-cloud-sdk/path.fish.inc'; end
