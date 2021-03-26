umask 0027

# Aliases
vims=('nvim' 'vim', 'vi')

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

if [ -f ~/.upkg/pcm/pcm.sh ]; then
    alias pcm='~/.upkg/pcm/pcm.sh'
fi
alias gst='git status -sb'
alias gsp='git status -uno -sb'
alias gp='git push'
alias gpl='git pull'
alias gplt='git pullt'
# alias greup='git reup'
# alias gcm='git cim'
# alias ga='git add'
alias jobs='jobs -l'
alias less=$PAGER
alias ll="ls  --group-directories-first --color=auto -l -t -h "
alias ls="ls -h --color=auto --group-directories-first"
alias open='xdg-open'
alias vif='nvim +Files'
# alias gvim='nvim-gtk'

if [[ "$TERM" == "xterm-kitty" ]]; then
    alias kcat='kitty +kitten icat'
    alias kdiff="kitty +kitten diff"
fi

# cmd_exists=$(command -v bat)
# if [[ -n $cmd_exists ]]; then
#     alias cat='bat --theme Monokai\ Extended\ Light'
# else
#     echo "Install 'bat' for a better cat"
# fi

cmd_exists=$(command -v prettyping)
if [[ -n $cmd_exists ]]; then
    alias ping='prettyping'
else
    echo "Install 'prettyping' for a better ping"
fi

# cmd_exists=$(command -v ncdu)
# if [[ -n $cmd_exists ]]; then
#     alias du='ncdu'
# else
#     echo "Install 'ncdu' for a better du"
# fi

export PATH=$HOME/bin:$PATH

# SSH Keychain
if [[ -x /usr/bin/ksshaskpass ]]
then
    export SSH_ASKPASS=/usr/bin/ksshaskpass
fi

if [[ -x /usr/bin/keychain ]]
then
   eval $(keychain --quiet --eval --agents ssh --inherit any id_rsa id_dsa)
fi

# Default to a light shell if not set otherwise.
if [[ -z $TERM_META ]]
then
    export TERM_META=light
fi

export PSQL_EDITOR='nvim -c"set ft=sql"'
export BROWSER=google-chrome
export EDITOR='nvim'
export VISUAL=vim


# https://github.com/metakirby5/codi.vim
# Codi
# Usage: codi [filetype] [filename]
# codi() {
#   local syntax="${1:-python}"
#   shift
#   nvim -c \
#     "let g:startify_disable_at_vimenter = 1 |\
#     set bt=nofile ls=0 noru nonu nornu |\
#     hi ColorColumn ctermbg=NONE |\
#     hi VertSplit ctermbg=NONE |\
#     hi NonText ctermfg=0 |\
#     Codi $syntax" "$@"
# }

alias ll='ls -l'

if [[ -x /usr/bin/exa ]]; then
    alias ls='exa'
    alias ll='ls -l --header'
fi

alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

if [[ -x /usr/bin/fzf ]]; then
    gch () {
        git checkout "$(git branch --list --sort=-refname --sort=-committerdate --color | fzf --ansi | tr -d '[:space:]')"
    }
fi
