#!/bin/bash

: "${ASDF_HOME?}"
: "${HOME?}"
: "${DOTFILES?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Haskell'
    return
fi

HASKELL_DOTFILES_VERSION='8.6.5'

setup_haskell() {
    asdf_bootstrap 'haskell' "${HASKELL_DOTFILES_VERSION}"
    if hash stack 2>/dev/null; then
        if [ ! -f "${HOME}/.ghci" ]
        then
            ln -s "${DOTFILES}/config/ghci" "${HOME}/.ghci"
            chmod go-w "${HOME}/.ghci"
        fi
        export PATH="${ASDF_HOME}/installs/haskell/${HASKELL_DOTFILES_VERSION}/bin:${PATH}"
        DOTFILES_FEATURES="haskell ${DOTFILES_FEATURES}"
    else
        log_error "Haskell toolset error: reinstall stack with asdf_bootstrap and try again."
    fi
}

setup_haskell

install_haskell_tools() {
    declare -a haskell_packages=(
        "ShellCheck"
        "dhall"
        "hindent"
        "hlint"
        "pandoc"
    )
    stack install "${haskell_packages[@]}"
}
