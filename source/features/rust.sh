#!/bin/bash

: "${HOME?}"
: "${ASDF_HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Rust'
    return
fi

RUST_DOTFILES_VERSION='stable'
export RUST_DOTFILES_VERSION

setup_rust() {
    asdf_bootstrap 'rust' "${RUST_DOTFILES_VERSION}"
    
    CARGO_PATH="${ASDF_HOME}/installs/rust/${RUST_DOTFILES_VERSION}"
    RUST_PATH="${CARGO_PATH}/bin"
    if [ -d "${RUST_PATH}" ]; then
        export RUST_PATH=${RUST_PATH}
        export PATH="${HOME}/.cargo/bin:${PATH}"
        # shellcheck source=/dev/null
        . "${CARGO_PATH}/env" 1&>- 2>&1
        DOTFILES_FEATURES="rust ${DOTFILES_FEATURES}"
    else
        log_error "Rust toolset error: \"${RUST_PATH}\" does not exist. Reinstall rustup and try again."
    fi
}

setup_rust

install_rust_tools() {
    declare -a rust_packages=(
        "clog-cli"
        "drill"
        "funzzy"
        "just"
        "ripgrep"
        "xsv"
    )
    cargo install "${rust_packages[@]}"
}
