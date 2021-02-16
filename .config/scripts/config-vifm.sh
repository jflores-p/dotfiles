#!/bin/sh

declare BIN="${HOME}/bin"

[[ ! -d $BIN ]] && mkdir $BIN
cd $BIN

declare IMG_DIR="cirala"
git clone https://github.com/cirala/vifmimg.git $IMG_DIR
cd $IMG_DIR

sudo mv vifmimg vifmrun $BIN
cd $BIN
sudo chmod 744 vifmimg vifmrun

cd $HOME
