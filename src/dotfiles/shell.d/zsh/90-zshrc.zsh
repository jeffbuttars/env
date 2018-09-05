
# Set vi mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# function zle-line-init zle-keymap-select {
#     VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#     RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#     zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select

# By default, there is a 0.4 second delay after you hit the <ESC> key and when
# the mode change is registered. This results in a very jarring and frustrating
# transition between modes. Let's reduce this delay to 0.1 seconds.
export KEYTIMEOUT=1

# Turn off spelling correction
unsetopt correct
unsetopt correctall

unsetopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt APPEND_HISTORY
export HISTFILE=~/.histfile
export HISTSIZE=10000000
export SAVEHIST=10000000

# CD whitout typing cd
AUTO_CD="true"

# Look for $HOME/.zsh_local
# That's where you put computer specific things that don't go in the repo
if [[ -f $HOME/.zsh_local ]]; then
    source $HOME/.zsh_local
fi

export EDITOR=vim
export VISUAL=vim

# Add the following 3 lines into your /home/jeff/.zshrc file
if [[ -f "/usr/lib/python3.6/site-packages/virtualcandy/lib/virtualcandy.zsh" ]]; then
    source "/usr/lib/python3.6/site-packages/virtualcandy/lib/virtualcandy.zsh"
fi