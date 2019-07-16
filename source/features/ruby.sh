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

sumdog_tools() {
    if [ -n "${SUMDOG_TOOLS_PATH}" ]; then
        pushd "${SUMDOG_TOOLS_PATH}" > /dev/null || return 
        sumdog_tools_cmd_prefix=''
        if hash aws-env > /dev/null 2>&1; then
            sumdog_tools_cmd_prefix='aws-env'
        fi
        "${sumdog_tools_cmd_prefix}" bundle exec sd "$@"
        popd > /dev/null || return
    else
        log_error "SUMDOG_TOOLS_PATH not set. Export it with an absolute path."
    fi
}
