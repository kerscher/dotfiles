#!/bin/bash

: "${HOME?}"
: "${DOTFILES?}"
: "${ASDF_HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Python'
    return
fi

PYTHON_DOTFILES_VERSION='3.7.4'

setup_python() {
    local DEFAULT_PYTHON_PACKAGES="${HOME}/.default-python-packages"
    if [ ! -f "${DEFAULT_PYTHON_PACKAGES}" ]
    then
        ln -s "${DOTFILES}/config/default-python-packages" "${DEFAULT_PYTHON_PACKAGES}"
    fi
    asdf_bootstrap 'python' "${PYTHON_DOTFILES_VERSION}"
    PYTHON_BIN_PATH="${ASDF_HOME}/installs/python/${PYTHON_DOTFILES_VERSION}/bin"
    if [ -d "${PYTHON_BIN_PATH}" ]
    then
        export PYTHON_BIN_PATH
        export PATH="${PYTHON_BIN_PATH}:${PATH}"
    else log_error "Could not add Python ${PYTHON_DOTFILES_VERSION} to path."
    fi
    DOTFILES_FEATURES="python ${DOTFILES_FEATURES}"
}

setup_python

install_python_tools() {
    declare -a python_packages=(
        "black"
        "isort"
        "mccabe"
        "mypy"
        "pycodestyle"
        "pydocstyle"
        "pyflakes"
        "pygments"
        "pyls-black"
        "pyls-isort"
        "pyls-mypy"
        "python-language-server[all]"
        "rope"
    )
    pip install --upgrade pip setuptools
    pip install --upgrade "${python_packages[@]}"
}
