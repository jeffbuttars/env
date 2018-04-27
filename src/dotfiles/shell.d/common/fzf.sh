# Use some of that ripgrep if it's around

v=$(which rg 2>&1 > /dev/null)
if [[ "0" == "$?" ]]; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
fi

# Initialize fasd
eval "$(fasd --init auto)"

# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2> /dev/null
z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
  cd "$(fasd_cd -d 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}
