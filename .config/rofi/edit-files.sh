#!/bin/bash
#  ____ _____
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/
# |____/ |_|
#
# Dmenu script for editing some of my more frequently edited config files.


declare -a options=("alacritty"
"bash"
"fish"
"fish-alias"
"fish-exports"
"neovim"
"picom"
"starship"
"qtile"
"vifm"
"xmobar"
"xmonad"
"zsh"
"zsh-alias"
"zsh-exports"
"quit"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | rofi -dmenu -p 'Edit config file: ')
case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
	bash)
		choice="$HOME/.bashrc"
    ;;
    fish)
        choice="$HOME/.config/fish/config.fish"
    ;;
    fish-alias)
        choice="$HOME/.config/fish/aliases.fish"
    ;;
    fish-exports)
        choice="$HOME/.config/fish/exports.fish"
	;;
	neovim)
		choice="$HOME/.config/nvim/init.vim"
    ;;
    starship)
        choice="$HOME/.config/starship.toml"
	;;
	qtile)
		choice="$HOME/.config/qtile/config.py"
	;;
	vifm)
		choice="$HOME/.config/vifm/vifmrc"
	;;
	xmobar)
		choice="$HOME/.config/xmobar/xmobarrc2"
	;;
	xmonad)
		choice="$HOME/.xmonad/xmonad.hs"
	;;
	zsh)
		choice="$HOME/.config/zsh/.zshrc"
	;;
	zsh-alias)
		choice="$HOME/.config/zsh/aliases.sh"
	;;
	zsh)
		choice="$HOME/.config/zsh/exports.sh"
	;;
	*)
		exit 1
	;;
esac

# Ultimately, what do want to do with our choice?  Open in our editor!
alacritty -e nvim "$choice"
# emacsclient -c -a emacs "$choice"
