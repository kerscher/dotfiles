#!/bin/bash

setup_go() {
    GOENV_ROOT="${HOME}/.goenv"
    GOENV_PATH="${GOENV_ROOT}/bin"
    GOPATH="${HOME}/go"
    if [ -d "${GOENV_ROOT}" ]; then
        export GOENV_ROOT="${GOENV_ROOT}"
        if [ ! -d "${GOPATH}" ]; then
            mkdir "${GOPATH}"
            export GOPATH="${GOPATH}"
        fi
        export PATH=${GOENV_PATH}:${GOPATH}/bin:${PATH}
        # shellcheck source=/dev/null
        eval "$(goenv init -)"
        DOTFILES_FEATURES="go ${DOTFILES_FEATURES}"
    else
        log_error "Go toolset error: \"${GOENV_ROOT}\" does not exist. Install from https://github.com/syndbg/goenv."
    fi
}

setup_go
