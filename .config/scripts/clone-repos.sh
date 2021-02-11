#!/bin/sh 

declare -a REPOS=("jflores-p/WallPapers" "jflores-p/shell-color-scripts" "zsh-users/zsh-syntax-highlighting" "romkatv/powerlevel10k")

cd $HOME
git clone "https://github.com/${REPOS[0]}.git"

git clone "https://github.com/${REPOS[1]}.git"
cd shell-color-scripts
makepkg -cf
sudo pacman -U *.pkg.tar.xz
cd $HOME
sudo rm -r shell-color-scripts

## zsh
cd $HOME/.config/zsh
git clone "https://github.com/${REPOS[2]}.git" "$HOME/.config/zsh/zsh-syntax-highlighting"
git clone "https://github.com/${REPOS[3]}.git" "$HOME/.config/zsh/powerlevel10k"

cd $HOME
