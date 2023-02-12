#!/usr/bin/env bash

# Aliases
vims=('nvim' 'vim' 'vi')

# Select which vim to use in order of preference. First found wins.

start_vim()
{
    for var in $vims
    do
        v=$(command -v $var)
        if [[ -n $v ]]
        then
            $v $@
            return $?
        fi
    done
}

alias vi=start_vim
alias vim=start_vim
alias svi="sudo -E vim"
alias vis='start_vim -O'

# default grep options
# Ignore VCS directories
# Ignore tags files
# Ignore binary files
alias grep="grep -I \
    --exclude-dir='.git'\
    --exclude-dir='.hg'\
    --exclude-dir='.svn'\
    --exclude-dir='.cvs'\
    --exclude='*\.pyo'\
    --exclude='*\.pyc'\
    --exclude='*~'\
    --exclude=TAGS\
    --exclude=tags"

# Enable PCM if it's around
if [ -f ~/.upkg/pcm/pcm.sh ]; then
    alias pcm='~/.upkg/pcm/pcm.sh'
fi

fit_add() {
    # Use fzf to multiple select file to add to the Git index
    local flist=""

    # git add "$(git status -s | fzf --multi --with-nth=2| xargs echo -en)"
    flist=$(git status -s | fzf --multi | awk '{print $2}')

    if [[ -z $flist ]]; then
        return
    fi

    while IFS= read -r line; do
        git add "$line"
        echo "git add '$line'"
    done <<< "$flist"

    echo ""
    git status -uno -sb
}

# Git aliases
alias gst='git status -sb'
alias gsp='git status -uno -sb'
alias gp='git push'
alias gpl='git pull'
alias gplt='git pullt'
alias greup='git reup'
alias gcm='git cim'
alias ga='git add'

alias ga=fit_add

alias jobs='jobs -l'
alias less="${PAGER}"
alias ll="ls  --group-directories-first --color=auto -l -t -h "
alias ls="ls -h --color=auto --group-directories-first"
alias open='xdg-open'
alias vif='nvim +Files'

if [[ "$TERM" == "xterm-kitty" ]]; then
    alias kcat='kitty +kitten icat'
    alias kdiff="kitty +kitten diff"
    alias icat='kitty +kitten icat'
fi

cmd_exists=$(command -v prettyping)
if [[ -n $cmd_exists ]]; then
    alias ping='prettyping'
else
    echo "Install 'prettyping' for a, pretry, ping"
fi

# cmd_exists=$(command -v ncdu)
# if [[ -n $cmd_exists ]]; then
#     alias du='ncdu'
# else
#     echo "Install 'ncdu' for a better du"
# fi

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
# alias docker-compose='docker compose'

if [[ -x /usr/bin/exa ]]; then
    alias ls='exa'
    alias ll='ls -l --header'
fi

# Fancy checkout branch picker with fzf
if [[ -x /usr/bin/fzf ]]; then
    gch () {
        git checkout "$(git branch --list --sort=-refname --sort=-committerdate --color | fzf --ansi | tr -d '[:space:]')"
    }
fi
