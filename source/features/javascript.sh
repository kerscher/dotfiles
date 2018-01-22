#!/bin/bash

setup_javascript() {
    NVM_DIR="${HOME}/.nvm"
    if [ -d "${NVM_DIR}" ]; then
        export NVM_DIR="${NVM_DIR}"
        # shellcheck source=/dev/null
        [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"
        DOTFILES_FEATURES="javascript ${DOTFILES_FEATURES}"
    else
        log_error "Javascript toolset error: \"${NVM_DIR}\" does not exist. Reinstall nvm and try again."
    fi
}

setup_javascript
