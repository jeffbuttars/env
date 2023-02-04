#!/usr/bin/env bash
# https://github.com/pypa/pip/issues/7883
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# This works around an issue with poetry unabled to detect python runtime on the system
# https://github.com/pypa/pipenv/issues/5075
export SETUPTOOLS_USE_DISTUTILS=stdlib

export VC_VENV_INITIAL_DEV_PKGS="pynvim isort black flake8 \
    mypy bandit data-science-types jedi jedi-language-server"

if [[ -f "$HOME/.pythonrc.py" ]]; then
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
fi

if [[ -f "$HOME/.pythonrc.py" ]]; then
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
fi

# POETRY
export POETRY_VIRTUALENVS_CREATE=true
export POETRY_VIRTUALENVS_IN_PROJECT=true

# https://python-poetry.org/docs/
install_poetry()
{
    curl -sSL https://install.python-poetry.org | python3 -
}

uninstall_poetry()
{
    curl -sSL https://install.python-poetry.org | python3 - --uninstall
}

#
# Setup some some functions to make switching between virtual envs fast, easy and automatic
function pyvenv_source_local_venv()
{
    if [[ -f ".env" ]]; then
        # shellcheck source=/dev/null
        source ".env"
    fi

    # shellcheck source=/dev/null
    source "$1"
}

function pyvenv_pyproject_find_nearest()
{
    local cur="$PWD"
    while [[ $cur != "/" ]]; do
        # echo $cur
        if [[ -f "$cur/pyproject.toml" && -d "$cur/.venv" ]]
        then
            echo "$cur"
            return 0
        fi

        cur=$(dirname "$cur")
    done

    echo ""
}

# Automatically activate/deactivate Poetry virtual environments
function pyvenv_pyproject_activate_deactivate_poetry_venv()
{
    # Can we find venv in our current or parent path?
    # -> NO: Are we in an active venv?
    #    -> YES: deactivate it
    #    -> NO: do nothing!
    #
    # -> YES: Are we already in a VENV?
    #    -> YES: Is it the same as the neareset project found?
    #       -> YES: Do nothing
    #       -> NO: Deactivate the current venv, and activate the found project
    #    -> NO: Activate the found project venv
    #
    #
    #
    #
    #

    proj_dir=$(pyvenv_pyproject_find_nearest)
    # echo "NEAREST: $proj_dir"

    # No project found in our current or parent dirs,
    # if we're in an active venv, deactivate it.
    if [[ -z "$proj_dir" ]]
    then
        if [[ $VIRTUAL_ENV ]]
        then
            if [[ $(command -v deactivate) ]]
            then
                deactivate
            fi
        fi

        echo "Deactivating venv"
        return 0
    fi

    proj_venv_dir="${proj_dir}/.venv"
    # echo "Found $proj_venv_dir"

    if [[ -z "$VIRTUAL_ENV" ]]
    then
        # We found a project, but we're not in an active venv,
        # so activate the found project and we're done.
        echo "Activating ~/${proj_dir/#$HOME/}"
        # source "${proj_venv_dir}/bin/activate"
        pyvenv_source_local_venv "${proj_venv_dir}/bin/activate"

        return 0
    fi

    # We have a found project and we're in an active venv
    # If the active venv and the project are the same, do nothing!
    if [[ "$VIRTUAL_ENV" == "$proj_venv_dir" ]]
    then
        # echo "Already active in $proj_dir"
        return 0
    fi

    # The active venv and found project don't match
    # so deactivate the current venv and activate the found project
    # echo "poetry VENV, $proj_venv_dir"
    # echo "Already in VENV: $VIRTUAL_ENV"
    echo "venv: ~/$(dirname "${VIRTUAL_ENV#$HOME/}") -> ~${proj_dir/#$HOME/}"

    if [[ $(command -v deactivate) ]]
    then
        deactivate
    fi

    # echo "Activating $proj_venv_dir"
    # source "${proj_venv_dir}/bin/activate"
    pyvenv_source_local_venv "${proj_venv_dir}/bin/activate"

} #pyvenv_activate_deactivate_poetry_venv
