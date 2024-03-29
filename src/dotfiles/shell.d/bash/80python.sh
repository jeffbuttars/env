#!/usr/bin/env bash

# Run the auto activation automagically
if [[ $(command -v poetry) ]]
then
    if [[ $(command -v starship) ]]; then
        echo "Setup starship"
        export starship_precmd_user_func="pyvenv_pyproject_activate_deactivate_poetry_venv"
    else
        if [[ -n "$PROMPT_COMMAND" ]]; then
            export VC_OLD_PROMPT_COMMAD="$PROMPT_COMMAND"
            PROMPT_COMMAND="$PROMPT_COMMAND;pyvenv_pyproject_activate_deactivate_poetry_venv"
        else
            PROMPT_COMMAND="pyvenv_pyproject_activate_deactivate_poetry_venv"
        fi
    fi
fi

# Run on startup
pyvenv_pyproject_activate_deactivate_poetry_venv
