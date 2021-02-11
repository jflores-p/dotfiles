
## Some minor exports

export TERM=alacritty
export EDITOR=nvim
export HISTCONTROL=ignoreboth

## GO
export GOPATH=$HOME/go
export GOHOME=/usr/local/go
export GOROOT=$GOHOME/1.15.7

useGo() {
    local goRoot=$GOHOME/$1
    echo "$goRoot"
    if [ -d "-goRoot" ]; then
        echo "Golang version $1 is not installed"
        return
    fi
    export GOROOT="$goRoot"
    export PATH=$PATH
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
export PATH=$PATH:$JAVA_HOME/bin:$GOROOT/bin:$GOPATH/bin

