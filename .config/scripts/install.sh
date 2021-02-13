#!/bin/sh

declare THIS_PATH=$HOME/.config/scripts

## 1
echo "Installando las fuentes"
source ${THIS_PATH}/install-fonts.sh

## 2
echo "Installando Golang ${1}"
source ${THIS_PATH}/install-go.sh $1

## 3
echo "Installando yay"
cd $HOME/Downloads
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si
cd $HOME

## 4 
echo "Clonando repositorios"
source ${THIS_PATH}/clone-repos.sh

## 5
echo "Installando cosas de pip"
sudo pacman -S python-pip
pip install ueberzug psutil

## 6 
echo "Configurando vifm"
source ${THIS_PATH}/config-vifm.sh
