#!/bin/bash

setup_keychain() {
    if command -v keychain 2>/dev/null; then
        eval "$(keychain --eval --quiet)"
        DOTFILES_FEATURES="keychain ${DOTFILES_FEATURES}"
    else
        log_error "SSH keychain error: \"keychain\" executable not found. Install and try again."
    fi
}

setup_keychain
