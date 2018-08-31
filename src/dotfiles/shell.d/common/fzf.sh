# Use some of that ripgrep if it's around

cmd_exists=$(command -v rg)
if [[ -n $cmd_exists ]]; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
    export FZF_DEFAULT_OPTS="--bind 'ctrl-o:execute(vim {})+abort'"
fi

# Initialize fasd
eval "$(fasd --init auto)"

# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2> /dev/null
z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
  cd "$(fasd_cd -d 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}

cmd_exists=$(command -v bat)
if [[ -n $cmd_exists ]]; then
    alias preview="fzf --preview 'bat --color \"always\" --theme Monokai\ Extended\ Light {}'"
fi

#v - open files in ~/.viminfo
v() {
  local files
  files=$(vim --headless +oldfiles +q 2>&1 | awk '{print $2}' |
          while read line; do
            echo "${line#$PWD/}" | dos2unix
          done | fzf-tmux -d -m -q "$*" -1)
  if [[ -n $files ]]; then
    vim $files
  fi
}

vo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    vim "$file"
  fi
}
