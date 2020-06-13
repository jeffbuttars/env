

if [[ $IS_REAL_TTY != 'true' ]]
then
    # poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry
    source "$HOME/.zprezto/init.zsh"
fi
