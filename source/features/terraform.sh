#!/bin/bash

TERRAFORM_DOTFILES_VERSION='0.11.14'

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
}

setup_terraform
