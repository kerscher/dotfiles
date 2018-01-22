#!/bin/bash

setup_terraform() {
    TFENV_ROOT="${HOME}/.tfenv"
    TFENV_PATH="${TFENV_ROOT}/bin"
    if [ -d "${TFENV_ROOT}" ]; then
        export PATH=${TFENV_PATH}:${PATH}
    else
        log_error "Terraform toolset error: \"${TFENV_ROOT}\" does not exist. Install from https://github.com/kamatama41/tfenv."
    fi
}

setup_terraform
