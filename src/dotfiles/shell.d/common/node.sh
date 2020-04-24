########################################
# NODE_PATH/NPM_PACKAGES Does not play with NVM
########################################


# NVM
# echo "nvm not installed?"
# echo 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash'

# mkdir -p $HOME/.nvm
# export NVM_DIR=$HOME/.nvm
# [ -f $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm


if [[ -z $NVM_DIR  ]]; then
    # no nvm
    # Localize the global nodejs installs
    export NPM_PACKAGES="$HOME/.npm-packages"

    export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

    if [[ ! -d "$NPM_PACKAGES" ]]; then
        mkdir -p "$NPM_PACKAGES"
    fi

    # MANPATH
    export MANPATH="$(manpath):$NPM_PACKAGES/share/man"
fi
