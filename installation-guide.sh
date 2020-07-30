#!/bin/bash 

func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###### The package "$1" is already installed"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "######  Installing package "  $1
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1 
    fi
}

###############################################################################
echo "Installation of sound software"
###############################################################################

list=(
	alacritty
	exa
	fish
	git
	htop
	lightdm
	lightdm-gtk-greeter
	lightdm-gtk-greeter-settings
	make
	neovim
	openssh
	python-pip
	qtile
	rofi
	unzip
	vifm
	xterm
	xf86-video-vmware
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;
	func_install $name
done
