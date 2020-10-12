export EDITOR=nvim
export TERM=alacritty

# Some minor exports
export EDITOR=nvim
export HISTCONTROL=ignoreboth

# GO
GOBBIN=/usr/local/go/bin

GOPATH1=$HOME/go
GOBIN1=$GOPATH1/bin

GOPATH2=$HOME/godev
GOBIN2=$GOPATH2/bin

export GOPATH=$GOPATH1:$GOPATH2
export GOBIN=$GOBIN1

# NodeJs
#VERSION='v12.18.3'
#DISTRO='linux-x64'
#NODEJS="/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/"

# MAN
export MANPATH=/usr/share/man

# JAVA
export JAVA_HOME="/opt/jdk-11.0.8+10"
#export JDK_HOME=/usr/lib/jvm/java-11-openjdk

# PATH -- configuracion base y despues añade extras
PATH="/home/joako/bin:/home/joako/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export PATH=$PATH:$GOBBIN:$GOBIN:$JAVA_HOME/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/joako/GoogleCloud/google-cloud-sdk/path.zsh.inc' ]; then . '/home/joako/GoogleCloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/joako/GoogleCloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/joako/GoogleCloud/google-cloud-sdk/completion.zsh.inc'; fi
