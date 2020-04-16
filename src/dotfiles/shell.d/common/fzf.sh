
# _gen_fzf_default_opts() {
#   local base03="234"
#   local base02="235"
#   local base01="240"
#   local base00="241"
#   local base0="244"
#   local base1="245"
#   local base2="254"
#   local base3="230"
#   local yellow="136"
#   local orange="166"
#   local red="160"
#   local magenta="125"
#   local violet="61"
#   local blue="33"
#   local cyan="37"
#   local green="64"
# 
#   # Comment and uncomment below for the light theme.
# 
#   # Solarized Dark color scheme for fzf
#   if [[ "$TERM_META" != 'light' ]]; then
#     export FZF_DEFAULT_OPTS="
#         --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
#         --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
#     "
#   else
#     # Solarized Light color scheme for fzf
#     export FZF_DEFAULT_OPTS="
#     --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
#     --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
#     "
#   fi
# }
# _gen_fzf_default_opts


# Use some of that ripgrep if it's around

cmd_exists=$(command -v rg)
if [[ -n $cmd_exists ]]; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
    export FZF_DEFAULT_OPTS="--bind 'ctrl-o:execute(vim {})+abort' $FZF_DEFAULT_OPTS"
else
    echo "install rg(ripgrep)"
fi

# Initialize fasd
cmd_exists=$(command -v fasd)
if [[ -n $cmd_exists ]]; then
    # eval "$(fasd --init auto)"


    fasd_cache="$HOME/.fasd-init-zsh"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
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
else
    echo "install fasd"
fi


# cmd_exists=$(command -v bat)
# if [[ -n $cmd_exists ]]; then
#     alias preview="fzf --preview 'bat --color \"always\" --theme Monokai\ Extended\ Light {}'"
# fi

#v - open files in ~/.viminfo
# v() {
#   local files
#   files=$(vim --headless +oldfiles +q 2>&1 | awk '{print $2}' |
#           while read line; do
#             echo "${line#$PWD/}" | dos2unix
#           done | fzf-tmux -d -m -q "$*" -1)
#   if [[ -n $files ]]; then
#     vim $files
#   fi
# }

# vo() {
#   local out file key
#   IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
#   key=$(head -1 <<< "$out")
#   file=$(head -2 <<< "$out" | tail -1)
#   if [ -n "$file" ]; then
#     vim "$file"
#   fi
# }
