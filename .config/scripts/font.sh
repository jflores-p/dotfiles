#!/bin/sh

[[ ! -d "$HOME/.local/share/fonts" ]] && mkdir -p $HOME/.local/share/fonts
cd $HOME/.local/share/fonts

declare -a fonts=("JetBrainsMono" "Hasklig" "Hermit" "RobotoMono" "FiraCode")
declare VERSION="v2.1.0"

for font in "${fonts[@]}"
do
    # si la fuente ya esta descargada, no se vuelve a descargar
    if [ ! -d $font ] 
    then   
        wget "https://github.com/ryanoasis/nerd-fonts/releases/download/$VERSION/$font.zip"
        unzip -d $font "$font.zip"
    fi
done

fc-cache
