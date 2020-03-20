
if [[ $IS_REAL_TTY != 'true' ]]
then
    # Powerline config
    # export POWERLEVEL9K_MODE='awesome-fontconfig'
    export POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
    export POWERLEVEL9K_SHORTEN_DELIMITER="-"
    export POWERLEVEL9K_SHORTEN_STRATEGY='truncate_middle'
    export POWERLEVEL9K_MODE='nerdfont-complete'
    export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv virtualenv vi_mode)
    export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(root_indicator background_jobs vcs)
    export POWERLEVEL9K_PROMPT_ON_NEWLINE=true

    # OhMyZsh powerleve10k installation
    # git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    # ZSH_THEME=powerlevel10k/powerlevel10k

    if [[ "$TERM_META" != 'dark' ]]
    then
        export POWERLEVEL9K_COLOR_SCHEME='light'
    fi

    if [[ -f "/usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme"  ]]
    then
        source  /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
    fi
fi
