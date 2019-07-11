#!/bin/bash

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Rust'
    return
fi

KUBECTL_DOTFILES_VERSION='1.14.4'
HELM_DOTFILES_VERSION='2.14.1'

setup_kubernetes() {
    asdf_bootstrap 'kubectl' "${KUBECTL_DOTFILES_VERSION}"
    asdf_bootstrap 'helm' "${HELM_DOTFILES_VERSION}"
    DOTFILES_FEATURES="kubernetes ${DOTFILES_FEATURES}"
}

setup_kubernetes
