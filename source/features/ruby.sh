#!/bin/bash

sumdog_tools() {
    if [ -n "${SUMDOG_TOOLS_PATH}" ]; then
        pushd "${SUMDOG_TOOLS_PATH}" > /dev/null || return 
        sumdog_tools_cmd_prefix=''
        if command -v aws-env > /dev/null 2>&1; then
            sumdog_tools_cmd_prefix='aws-env'
        fi
        "${sumdog_tools_cmd_prefix}" bundle exec sd "$@"
        popd > /dev/null || return
    else
        log_error "SUMDOG_TOOLS_PATH not set. Export it with an absolute path."
    fi
}

setup_ruby() {
    RBENV_PATH="${HOME}/.rbenv/bin"
    if [ -d "${RBENV_PATH}" ]; then
        export RBENV_PATH="${RBENV_PATH}"
        export PATH=${RBENV_PATH}:${PATH}
        eval "$(rbenv init -)"
        DOTFILES_FEATURES="ruby ${DOTFILES_FEATURES}"
    else
        log_error "Ruby toolset error: \"${RBENV_PATH}\" does not exist. Reinstall rbenv and try again."
    fi
}

setup_ruby
