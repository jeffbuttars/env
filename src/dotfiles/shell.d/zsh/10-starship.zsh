#!/bin/zsh

STARSHIP_CMD=$(command -v starship)
if [[ $STARSHIP_CMD ]]
then
    starshipt_cache="$HOME/.starship-init-zsh"
    eval "$(starship init zsh)"

    if [ /usr/bin/starship -nt "$starshipt_cache" -o ! -s "$starshipt_cache" ]; then
        starship init zsh >| "$starshipt_cache"
    fi

    source "$starshipt_cache"
    unset starshipt_cache
else
    echo "install 'starship' for a pretty prompt"
fi
