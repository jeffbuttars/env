
function pyproject_find_nearest()
{
    local cur="$PWD"
    while [[ $cur != "/" ]]; do
        if [[ -f "$cur/pyproject.toml" ]]
        then
            echo "$cur"
            return 0
        fi

        cur=$(dirname $cur)
    done

    echo ""
}

# Automatically activate/deactivate Poetry virtual environments
function pyproject_activate_deactivate_poetry_venv()
{
    proj_dir=$(pyproject_find_nearest)
    echo "NEAREST: $proj_dir"

    if [[ -n "$proj_dir" ]]
    then
        # local venv="$proj_dir/$VIRTUAL_ENV"
        # local venv_path=$(poetry env info --path)
        # echo "Activating Python virtualenv $venv_path"
        # source "${venv_path}/bin/activate"
        if [[ "$VIRTUAL_ENV" ]]
        then

            # echo "Already in VENV, $VIRTUAL_ENV"
            # Deactivate the current VENV so we can activate the VENV in CWD
            if [[ "$VIRTUAL_ENV" != "$PWD/.venv" ]]
            then
                echo -en "Deactivating ~/${VIRTUAL_ENV#$HOME/}, "
                deactivate
            fi
        fi

        local venv=$(poetry env info --path)
        echo "Activating ~/${venv#$HOME/}"
        source "${venv}/bin/activate"
    elif [[ $VIRTUAL_ENV ]]
    then
        # If the VENV that is currently active is from a parent dir,
        # leave it active. Otherwise, deactivate it.
        # echo "Deactivating Python virtualenv $VIRTUAL_ENV"
        local vdir=$(readlink -f $(dirname $VIRTUAL_ENV))
        RE_MATCH_PCRE=true

        if [[ ! "${PWD}" =~ "^${vdir}.*" ]]
        then
            echo "Deactivating $vdir"
            deactivate
        fi
    fi
} #activate_deactivate_poetry_venv

if [[ $(command -v poetry) ]]
then
    chpwd_functions=(${chpwd_functions[@]} "pyproject_activate_deactivate_poetry_venv")
fi

export PATH="$HOME/.poetry/bin:$PATH:/usr/local/bin"

# Run on startup
pyproject_activate_deactivate_poetry_venv
