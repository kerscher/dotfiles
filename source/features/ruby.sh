#!/bin/bash

: "${HOME?}"
: "${ASDF_HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Ruby'
    return
fi

RUBY_DOTFILES_VERSION='2.6.3'

setup_ruby() {
    asdf_bootstrap 'ruby' "${RUBY_DOTFILES_VERSION}"
    RUBY_BIN_PATH="${ASDF_HOME}/installs/ruby/${RUBY_DOTFILES_VERSION}/bin"
    if [ -d "${RUBY_BIN_PATH}" ]
    then
        export RUBY_BIN_PATH
        export PATH="${RUBY_BIN_PATH}:${PATH}"
    else log_error "Could not add Ruby ${RUBY_DOTFILES_VERSION} to path."
    fi
    DOTFILES_FEATURES="ruby ${DOTFILES_FEATURES}"
}

setup_ruby

install_ruby_tools() {
    declare -a ruby_packages=(
        'test-kitchen'
        'kitchen-ansible'
        'kitchen-docker'
        'kitchen-vagrant'
        'kitchen-inspec'
        'inspec-bin'
    )
    gem install "${ruby_packages[@]}"
}
