#!/bin/bash

setup_ruby() {
    RBENV_PATH="${HOME}/.rbenv/bin"
    if [ -d "${RBENV_PATH}" ]; then
        export RBENV_PATH="${RBENV_PATH}"
        export PATH=${RBENV_PATH}:${PATH}
        eval "$(rbenv init -)"
        DOTFILES_FEATURES="ruby ${DOTFILES_FEATURES}"
    else
        log_error "Ruby toolset error: \"${RBENV_PATH}\" does not exist. Reinstall rbenv and try again."
    fi
}

setup_ruby
