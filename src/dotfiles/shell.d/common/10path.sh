#!/usr/bin/env bash

update_path_if_exists "${HOME}/bin"
update_path_if_exists "${HOME}/.local/bin"
update_path_if_exists "/usr/local/bin"

# Prefer the 'local' nvim
update_path_if_exists "/usr/local/nvim/bin"
update_path_if_exists "/usr/local/bin/nvim/bin"

update_path_if_exists "$HOME/.cargo/bin" # Add cargo bin
update_path_if_exists "${HOME}/.luarocks/bin"
update_path_if_exists "${HOME}/.rvm/bin"
update_path_if_exists "${HOME}/.go/bin"
update_path_if_exists "${HOME}/go/bin"
# update_path_if_exists "$HOME/.poetry/bin" true

# echo "PATH: $PATH"
