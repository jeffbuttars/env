
export VC_VENV_INITIAL_DEV_PKGS="pynvim flake8 isort black"

if [[ "$HOME/.pythonrc.py" ]]; then
    export PYTHONSTARTUP="$HOME/.pythonrc.py"
fi
