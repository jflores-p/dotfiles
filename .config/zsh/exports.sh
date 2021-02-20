
## Some minor exports

export TERM=alacritty
export EDITOR=nvim
export HISTCONTROL=ignoreboth

## GO
export GOPATH=$HOME/go
export GOHOME=/usr/local/go
# export GOROOT=$GOHOME/1.16
export GOROOT=$GOHOME/1.15.8

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

## LIBBRARY

declare LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH

## NodeJs
VERSION=v14.15.5
DISTRO=linux-x64
NODEJS=/usr/local/nodejs/node-$VERSION-$DISTRO

## MAN
export MANPATH=/usr/share/man

## JAVA
# adoptopenjdk
JAVA_VERSION=15.0.2+7
export JAVA_HOME=/usr/local/java/jdk-$JAVA_VERSION

# PATH -- configuracion base y despues añade extras
PATH="/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/bin/core_perl:/usr/bin/site_perl:/usr/bin/vendor_perl:/home/joako/.local/bin"
export PATH=$PATH:$NODEJS/bin:$JAVA_HOME/bin:$GOROOT/bin:$GOPATH/bin

