EDITOR="nvim"
export TERM="xterm-256color"

# Some minor fixes
export EDITOR=nvim
export HISTCONTROL=ignoreboth

# GO
export GOBBIN=/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOPATH=$GOPATH:$HOME/gowork

# NodeJs
#VERSION='v12.18.3'
#DISTRO='linux-x64'
#NODEJS="/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/"

# PATH -- configuracion base y despues añade extras
PATH="/home/joako/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export PATH=$PATH:$GOBBIN:$GOBIN
