#!/bin/bash

setup_terraform() {
    TFENV_ROOT="${HOME}/.tfenv"
    TFENV_PATH="${TFENV_ROOT}/bin"
    if [ -d "${TFENV_ROOT}" ]; then
        export PATH=${TFENV_PATH}:${PATH}

        tf() { aws-env -p default terraform "$@"; };

        tf_feedback() {
            while sleep 1
            do
                find . -maxdepth 1 -iname '*.tf' \
                    | entr -c -d sh -c \
                           'tf init && tf validate'
            done
        }
    else
        log_error "Terraform toolset error: \"${TFENV_ROOT}\" does not exist. Install from https://github.com/kamatama41/tfenv."
    fi
}

setup_terraform
