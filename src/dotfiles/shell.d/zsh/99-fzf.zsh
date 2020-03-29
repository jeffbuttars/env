# Setup fzf
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
