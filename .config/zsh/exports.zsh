export EDITOR=nvim
export TERM=alacritty

# Some minor exports
export EDITOR=nvim
export HISTCONTROL=ignoreboth

# GO
GOBBIN=/usr/local/go/bin

GOPATH1=$HOME/go
GOBIN1=$GOPATH1/bin

GOPATH2=$HOME/gowork
GOBIN2=$GOPATH2/bin

export GOPATH=$GOPATH2:$GOPATH1
export GOBIN=$GOBIN1

# NodeJs
#VERSION='v12.18.3'
#DISTRO='linux-x64'
#NODEJS="/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/"

# MAN
export MANPATH=/usr/share/man


# PATH -- configuracion base y despues añade extras
PATH="/home/joako/bin:/home/joako/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export PATH=$PATH:$GOBBIN:$GOBIN
