# Localize the global nodejs installs
export NPM_PACKAGES="$HOME/.npm-packages"

export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

if [[ ! -d "$NPM_PACKAGES" ]]; then
    mkdir -p "$NPM_PACKAGES"
fi

# MANPATH
export MANPATH="$(manpath):$NPM_PACKAGES/share/man"

# NVM
if [[ -f /usr/share/nvm/init-nvm.sh  ]]; then
    source /usr/share/nvm/init-nvm.sh
fi

mkdir -p $HOME/.nvm
export NVM_DIR=$HOME/.nvm
[ -f $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh

