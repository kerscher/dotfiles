#!/bin/bash

setup_git() {
    if command -v git 2>/dev/null; then
        if [ ! -f "${HOME}/.gitignore" ]; then
            ln -s "${DOTFILES}/config/gitignore" "${HOME}/.gitignore"
            git config --global core.excludesfile "${HOME}/.gitignore"
        fi
        DOTFILES_FEATURES="git ${DOTFILES_FEATURES}"
    else
        log_error "Git error: no git executable found. Install and try again."
    fi
}

setup_git
