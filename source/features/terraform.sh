#!/bin/bash

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Terraform'
    return
fi

TERRAFORM_DOTFILES_VERSION='0.12.10'

setup_terraform() {
    asdf_bootstrap 'terraform' "${TERRAFORM_DOTFILES_VERSION}"

    if hash aws-env 2> /dev/null
    then
        tf() { aws-env terraform "$@"; };

        if hash entr 2> /dev/null
        then
            tf_feedback() {
                while sleep 1
                do
                    find . -maxdepth 1 -iname '*.tf' \
                        | entr -c -d bash -c \
                               'aws-env -p default terraform init && aws-env -p default terraform validate'
                done
            }
        fi
    fi
    DOTFILES_FEATURES="terraform ${DOTFILES_FEATURES}"
}

setup_terraform
