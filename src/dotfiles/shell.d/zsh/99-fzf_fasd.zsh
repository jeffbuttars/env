# Setup fzf
# zsh-hook             # define _fasd_preexec and add it to zsh preexec array
# zsh-ccomp            # zsh command mode completion definitions
# zsh-ccomp-install    # setup command mode completion for zsh
# zsh-wcomp            # zsh word mode completion definitions
# zsh-wcomp-install    # setup word mode completion for zsh
# bash-hook            # add hook code to bash $PROMPT_COMMAND
# bash-ccomp           # bash command mode completion definitions
# bash-ccomp-install   # setup command mode completion for bash
# posix-alias          # define aliases that applies to all posix shells
# posix-hook           # setup $PS1 hook for shells that's posix compatible
# tcsh-alias           # define aliases for tcsh
# tcsh-hook            # setup tcsh precmd alias
# eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Initialize fasd
fasd_cmd_exists=""
if [[ -f /usr/bin/fasd ]]
then
    fasd_cmd_exists='/usr/bin/fasd'
fi

if [[ -n $fasd_cmd_exists ]]; then
    eval "$(fasd --init auto)"

    fasd_cache="$HOME/.fasd-init-zsh"
    if [ "$fasd_cmd_exists" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init auto >| "$fasd_cache"
    fi

    source "$fasd_cache"
    unset fasd_cache

    # like normal z when used with arguments but displays an fzf prompt when used without.
    unalias z 2> /dev/null
    z() {
        [ $# -gt 0 ] && fasd_cd -d "$*" && return
    cd "$(fasd_cd -d 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
    }

    # ---------
    if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
      export PATH="$PATH:${HOME}/.fzf/bin"
    fi

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------

    if [[ -f  "/usr/share/fzf/key-bindings.zsh" ]]; then
        source "/usr/share/fzf/key-bindings.zsh" 
    elif [[ -f  "$HOME/.fzf/shell/key-bindings.zsh" ]]; then
        source "$HOME/.fzf/shell/key-bindings.zsh"
    fi
else
    echo "install fasd"
fi

# load up some fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
