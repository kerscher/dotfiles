#!/bin/bash

: "${HOME?}"

ASDF_HOME="${HOME}/.asdf"
export ASDF_HOME

if [ ! -d "${ASDF_HOME}" ]
then
    if ! hash git 2> /dev/null
    then
        log_error 'You need git to install asdf.'
        return
    fi
    git clone https://github.com/asdf-vm/asdf.git "${ASDF_HOME}"
    pushd "${ASDF_HOME}" || return
    git checkout "$(git describe --abbrev=0 --tags)"
    asdf update || { log_error 'Can'\''t exit ASDF installation folder'; return ; } ;
fi

ASDF_INIT="${ASDF_HOME}/asdf.sh"
if [ -r "${ASDF_INIT}" ]
then
    # shellcheck source=/dev/null
    . "${ASDF_INIT}"
else
    echo "Error: could not initialise asdf. Ensure ${ASDF_INIT} exists and is readable"
fi
unset ASDF_INIT

ASDF_COMPLETIONS="${ASDF_HOME}/completions/asdf.bash"
if [ -r "${ASDF_COMPLETIONS}" ]
then
    # shellcheck source=/dev/null
    . "${ASDF_COMPLETIONS}"
else
    echo "Error: could not add completions for asdf. Ensure ${ASDF_COMPLETIONS} exists and is readable"
fi
unset ASDF_COMPLETIONS
DOTFILES_FEATURES="asdf ${DOTFILES_FEATURES}"

asdf_bootstrap() {
    : "${1?Provide plugin for asdf as first argument}"
    : "${2?Provide version for asdf plugin of first argument as second argument}"
    if ! hash asdf 2> /dev/null
    then
        log_error "${1} cannot be installed without asdf"
        return
    fi

    if ! { asdf plugin-list | grep "${1}" > /dev/null ; }
    then
        asdf plugin-add "${1}"
    fi

    if ! { asdf list "${1}" | grep "${2}" > /dev/null ; }
    then
        asdf install "${1}" "${2}"
    fi
    asdf global "${1}" "${2}"
}
