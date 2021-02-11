#!/bin/sh

[[ ! -d "$HOME/Downloads" ]] && mkdir $HOME/Downloads
cd $HOME/Downloads

declare GO_VER=$1
declare GO_DIR="/usr/local/go/${GO_VER}"

if [ ! -d ${GO_DIR} ]; then
    echo "Creando ${GO_DIR}"
    sudo mkdir ${GO_DIR}
fi

if [ "$(/usr/bin/ls -A ${GO_DIR})" ]; then
    echo "Golang version ${GO_VER} ya se encuentra instalada"
    
else
    wget "https://golang.org/dl/go${GO_VER}.linux-amd64.tar.gz"

    sudo tar -C ${GO_DIR} -xzf "go${GO_VER}.linux-amd64.tar.gz"
    
    sudo "go${GO_VER}.linux-amd64.tar.gz"
fi

cd $HOME
