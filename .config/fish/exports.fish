set fish_greeting
set TERM "xterm-256color"
set EDITOR "neovim"

## Golang
set -x GOPATH $HOME/go
set -l GOHOME /usr/local/go
# set -l GOROOT $GOHOME/1.16
set -x GOROOT $GOHOME/1.15.8

## NodeJs
set VERSION v14.15.5
set DISTRO linux-x64
set NODEJS /usr/local/nodejs/node-$VERSION-$DISTRO

## MAN
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -a PATH $NODEJS/bin $HOME/.local/bin $GOROOT/bin $GOPATH/bin
