umask 0027

# Aliases
vims=('nvim' 'vim')

# Select which vim to use in order of preference. First found wins.
for var in $vims
do
    v=$(command -v $var)
    if [[ -n $v ]]
    then
        alias vi="$var"
        alias vim="$var"
        alias svi="sudo -E $var"
        alias vis="$var -O"
        break
    fi
done

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
alias gst='git status'
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

# if [[ -d  "$HOME/.rvm/bin" ]]; then
#     export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# fi

# if [[ /opt/android-sdk ]]; then
#     export ANDROID_HOME='/opt/android-sdk'
#     export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
# fi

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

export PSQL_EDITOR='vim -c"set ft=sql"'
export BROWSER=google-chrome
export EDITOR='vim'
