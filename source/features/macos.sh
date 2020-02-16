#!/bin/bash

setup_macOS() {
    if type sw_vers &> /dev/null
    then
        export BASH_SILENCE_DEPRECATION_WARNING=1
    fi
    DOTFILES_MACTEX_PATH='/Library/Tex/texbin'
    if [ -d "${DOTFILES_MACTEX_PATH}" ]
    then export PATH="${DOTFILES_MACTEX_PATH}:${PATH}"
    fi
}

setup_macOS
