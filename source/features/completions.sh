#!/bin/bash

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        # shellcheck source=/dev/null
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        # shellcheck source=/dev/null
        . /etc/bash_completion
    fi
fi

if type brew &> /dev/null
then
    HOMEBREW_PREFIX="$(brew --prefix)"
    HOMEBREW_COMPLETION_COMPAT_DIR="${HOMEBREW_PREFIX}/etc/bash_completion.d"
    [[ -d "${HOMEBREW_COMPLETION_COMPAT_DIR}" ]] && export BASH_COMPLETION_COMPAT_DIR="${HOMEBREW_COMPLETION_COMPAT_DIR}"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
    then
        # shellcheck source=/dev/null
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        for c in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
        do
            # shellcheck source=/dev/null
            [ -r "${c}" ] && source "${c}"
        done
    fi
    # shellcheck source=/dev/null
    BASH_SYSTEM_COMPLETIONS='/usr/local/etc/bash_completion.d'
    if [ -d "${BASH_SYSTEM_COMPLETIONS}" ]
    then
        for c in "${BASH_SYSTEM_COMPLETIONS}/"*
        do
            # shellcheck source=/dev/null
            [ -r "${c}" ] && source "${c}"
        done
    fi
fi
