#!/bin/bash

: "${HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Ruby'
    return
fi

RUBY_DOTFILES_VERSION='2.6.3'

setup_ruby() {
    asdf_bootstrap 'ruby' "${RUBY_DOTFILES_VERSION}"
    DOTFILES_FEATURES="ruby ${DOTFILES_FEATURES}"
}

setup_ruby
