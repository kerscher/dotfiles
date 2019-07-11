#!/bin/bash

: "${HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Rust'
    return
fi

GOLANG_DOTFILES_VERSION='1.12.7'

setup_go() {
    asdf_bootstrap 'golang' "${GOLANG_DOTFILES_VERSION}"
    
    GOPATH="${HOME}/go"
    if [ ! -d "${GOPATH}" ]; then
        mkdir "${GOPATH}"
        export GOPATH="${GOPATH}"
    fi
    export PATH=${GOPATH}/bin:${PATH}
    DOTFILES_FEATURES="go ${DOTFILES_FEATURES}"
}

setup_go
