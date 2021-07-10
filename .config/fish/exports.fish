set fish_greeting
set -x TERM "xterm-256color"
set -x EDITOR "nvim"

## Golang
set -x GOPATH $HOME/go
set -x GOBIN $GOPATH/bin
set -l GOHOME /usr/local/go
# set -l GOROOT $GOHOME/1.16
set -x GOROOT $GOHOME/1.15.8

## NodeJs
set VERSION v14.15.5
set DISTRO linux-x64
set NODEJS /usr/local/nodejs/node-$VERSION-$DISTRO

## LIBBRARIES
set -x LD_LIBRARY_PATH /lib /usr/lib /usr/local/lib

## MAN
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -a PATH $NODEJS/bin $HOME/.local/bin $GOROOT/bin $GOPATH/bin
