
export VC_VENV_INITIAL_DEV_PKGS="neovim flake8 pylint isort"

if [[ "$HOME/.pythonrc.py" ]]; then
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
fi
