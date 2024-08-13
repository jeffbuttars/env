#!/usr/bin/env bash

umask 0027

_list_ssh_priv_keys() {
  local keys=""
  local extension

  for key in ~/.ssh/id_*; do
    extension=${key##*.}
    privname="${key%.*}"
    # echo "$key $privname $extension"
    if [[ "$extension" == "pub" ]] && [[ -f "$privname" ]]; then
      keys+="$(basename "${privname}") "
    fi
  done

  echo $keys
}

# Create some dirs for vim to put backup, swap files, etc. into
mkdir -p "${HOME}/tmp/.vim/{backup,swap,undo}"

# SSH Keychain
if [[ -x /usr/bin/ksshaskpass ]]; then
  export SSH_ASKPASS=/usr/bin/ksshaskpass
fi

if [[ -x /usr/bin/keychain ]]; then
  # eval "$(keychain --quiet --eval --agents ssh --inherit any id_rsa)"
  eval "$(keychain --quiet --eval --agents ssh --inherit any $(_list_ssh_priv_keys))"
fi

# Default to a light shell if not set otherwise.
if [[ -z $TERM_META ]]; then
  export TERM_META=light
fi

export PSQL_EDITOR='nvim -c"set ft=sql"'
export BROWSER=google-chrome
export EDITOR=nvim
export VISUAL=vim

# Neovide
export NeovideMultiGrid=true
NEOVIDE_MULTIGRID=true
export NEOVIDE_MULTIGRID

source_if_exists "${HOME}/.cargo/env"

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
