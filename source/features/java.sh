#!/bin/bash

: "${HOME?}"
: "${DOTFILES?}"
: "${ASDF_HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Python'
    return
fi

JAVA_DOTFILES_VERSION='amazon-corretto-11.0.3.7.1'
GROOVY_DOTFILES_VERSION='apache-groovy-binary-2.5.8'

setup_java() {
    asdf_bootstrap 'java' "${JAVA_DOTFILES_VERSION}"
    asdf_bootstrap 'groovy' "${GROOVY_DOTFILES_VERSION}"
    java_home_setup_scrip_path="${ASDF_HOME}/plugins/java/set-java-home.sh"
    if [ -f "${java_home_setup_scrip_path}" ]
    then
        # shellcheck source=/dev/null
        source "${java_home_setup_scrip_path}"
    fi
    DOTFILES_FEATURES="java ${DOTFILES_FEATURES}"
}

setup_java
