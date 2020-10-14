
export VC_VENV_INITIAL_DEV_PKGS="pynvim isort black flake8 flake8-isort \
    flake8-black flake8-bugbear mypy bandit data-science-types"

if [[ "$HOME/.pythonrc.py" ]]; then
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
fi


# POETRY
export POETRY_VIRTUALENVS_CREATE=true
export POETRY_VIRTUALENVS_IN_PROJECT=true
