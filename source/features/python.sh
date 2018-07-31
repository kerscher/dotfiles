#!/bin/bash

setup_python() {
    PYENV_PATH="${HOME}/.pyenv/bin"
    if [ -d "${PYENV_PATH}" ]; then
        export PYENV_PATH="${PYENV_PATH}"
        export PYENV_VIRTUALENV_DISABLE_PROMPT=1
        export PATH="${PYENV_PATH}:${PATH}"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
        DOTFILES_FEATURES="python ${DOTFILES_FEATURES}"
    else
        log_error "Python toolset error: \"${PYENV_PATH}\" does not exist. Reinstall pyenv and try again."
    fi
}

setup_python
