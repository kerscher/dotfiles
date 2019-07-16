#!/bin/bash

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Packer'
    return
fi

PACKER_DOTFILES_VERSION='1.4.0'

setup_packer() {
    asdf_bootstrap 'packer' "${PACKER_DOTFILES_VERSION}"
    DOTFILES_FEATURES="packer ${DOTFILES_FEATURES}"
}

setup_packer
