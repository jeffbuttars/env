
export VC_VENV_INITIAL_DEV_PKGS="pynvim isort black flake8 \
    mypy bandit data-science-types python-language-server pyls-flake8 pyls-black"

if [[ "$HOME/.pythonrc.py" ]]; then
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
fi


# POETRY
export POETRY_VIRTUALENVS_CREATE=true
export POETRY_VIRTUALENVS_IN_PROJECT=true

if [[ -f $HOME/.poetry/env ]]; then
    source $HOME/.poetry/env
fi

# https://python-poetry.org/docs/#installation
# curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
install_poetry()
{
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
}
