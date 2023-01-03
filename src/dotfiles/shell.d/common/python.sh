#!/usr/bin/env bash
# https://github.com/pypa/pip/issues/7883
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

export VC_VENV_INITIAL_DEV_PKGS="pynvim isort black flake8 \
    mypy bandit data-science-types python-language-server pyls-flake8 pyls-black"

if [[ -f "$HOME/.pythonrc.py" ]]; then
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
fi

if [[ -f "$HOME/.poetry/bin" ]]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

# POETRY
export POETRY_VIRTUALENVS_CREATE=true
export POETRY_VIRTUALENVS_IN_PROJECT=true

# https://python-poetry.org/docs/#installation
# curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
install_poetry()
{
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
}
