#!/bin/zsh

# Setup some some functions to make switching between virtual envs fast, easy and automatic
# function source_local_venv()
# {
#     if [[ -f ".env" ]]
#     then
#         source ".env"
#     fi
#
#     source $1
# }
#
# function pyproject_find_nearest()
# {
#     local cur="$PWD"
#     while [[ $cur != "/" ]]; do
#         # echo $cur
#         if [[ -f "$cur/pyproject.toml" && -d "$cur/.venv" ]]
#         then
#             echo "$cur"
#             return 0
#         fi
#
#         cur=$(dirname $cur)
#     done
#
#     echo ""
# }
#
# # Automatically activate/deactivate Poetry virtual environments
# function pyproject_activate_deactivate_poetry_venv()
# {
#     # Can we find venv in our current or parent path?
#     # -> NO: Are we in an active venv?
#     #    -> YES: deactivate it
#     #    -> NO: do nothing!
#     #
#     # -> YES: Are we already in a VENV?
#     #    -> YES: Is it the same as the neareset project found?
#     #       -> YES: Do nothing
#     #       -> NO: Deactivate the current venv, and activate the found project
#     #    -> NO: Activate the found project venv
#     #
#     #
#     #
#     #
#     #
#
#     proj_dir=$(pyproject_find_nearest)
#     # echo "NEAREST: $proj_dir"
#
#     # No project found in our current or parent dirs,
#     # if we're in an active venv, deactivate it.
#     if [[ -z "$proj_dir" ]]
#     then
#         if [[ $VIRTUAL_ENV ]]
#         then
#             if [[ $(command -v deactivate) ]]
#             then
#                 deactivate
#             fi
#         fi
#
#         echo "Deactivating venv"
#         return 0
#     fi
#
#     proj_venv_dir="${proj_dir}/.venv"
#     # echo "Found $proj_venv_dir"
#
#     if [[ -z "$VIRTUAL_ENV" ]]
#     then
#         # We found a project, but we're not in an active venv,
#         # so activate the found project and we're done.
#         echo "Activating ~/${proj_dir/#$HOME/}"
#         # source "${proj_venv_dir}/bin/activate"
#         source_local_venv "${proj_venv_dir}/bin/activate"
#
#         return 0
#     fi
#
#     # We have a found project and we're in an active venv
#     # If the active venv and the project are the same, do nothing!
#     if [[ "$VIRTUAL_ENV" == "$proj_venv_dir" ]]
#     then
#         # echo "Already active in $proj_dir"
#         return 0
#     fi
#
#     # The active venv and found project don't match
#     # so deactivate the current venv and activate the found project
#     # echo "poetry VENV, $proj_venv_dir"
#     # echo "Already in VENV: $VIRTUAL_ENV"
#     echo "venv: ~/$(dirname ${VIRTUAL_ENV#$HOME/}) -> ~${proj_dir/#$HOME/}"
#
#     if [[ $(command -v deactivate) ]]
#     then
#         deactivate
#     fi
#
#     # echo "Activating $proj_venv_dir"
#     # source "${proj_venv_dir}/bin/activate"
#     source_local_venv "${proj_venv_dir}/bin/activate"
#
# } #activate_deactivate_poetry_venv

if [[ $(command -v poetry) ]]
then
    chpwd_functions=(${chpwd_functions[@]} "pyvenv_pyproject_activate_deactivate_poetry_venv")
fi

# Run on startup
pyvenv_pyproject_activate_deactivate_poetry_venv
