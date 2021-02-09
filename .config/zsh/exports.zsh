
## Some minor exports

export TERM=alacritty
export EDITOR=nvim
export HISTCONTROL=ignoreboth

## GO

GOPATH=$HOME/go
GOBIN1=$GOPATH1/bin

# GOPATH2=$HOME/godev
# GOBIN2=$GOPATH2/bin

# export GOPATH=$GOPATH1:$GOPATH2
# export GOBIN=$GOBIN1

export GOHOME=/usr/local/go

useGo() {
    local goRoot=$GOHOME/$1
    echo "$goRoot"
    if [ -d "-goRoot" ]; then
        echo "Golang version $1 is not installed"
        return
    fi
    export GOROOT="$goRoot"
    go version
}

## NodeJs
#VERSION='v12.18.3'
#DISTRO='linux-x64'
#NODEJS="/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/"

## MAN
export MANPATH=/usr/share/man

## JAVA
# adoptopenjdk
export JAVA_HOME="/opt/jdk-11.0.9+11"

# PATH -- configuracion base y despues añade extras
PATH="/home/joako/bin:/home/joako/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export PATH=$PATH:$GOROOT:$JAVA_HOME/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/joako/GoogleCloud/google-cloud-sdk/path.zsh.inc' ]; then . '/home/joako/GoogleCloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.

