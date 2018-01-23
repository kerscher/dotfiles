#!/bin/bash

setup_haskell() {
    if hash stack 2>/dev/null; then
        if [ ! -f "${HOME}/.ghci" ]; then
            ln -s "${DOTFILES}/config/ghci" "${HOME}/.ghci"
        fi
        eval "$(stack --bash-completion-script stack)"
        DOTFILES_FEATURES="haskell ${DOTFILES_FEATURES}"
    else
        log_error "Haskell toolset error: reinstall stack and try again."
    fi
}

setup_haskell
