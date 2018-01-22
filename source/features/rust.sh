#!/bin/bash

setup_rust() {
    CARGO_PATH="${HOME}/.cargo"
    RUST_PATH="${CARGO_PATH}/bin"
    if [ -d "${RUST_PATH}" ]; then
        export RUST_PATH=${RUST_PATH}
        export PATH=${RUST_PATH}:${PATH}
        # shellcheck source=/dev/null
        . "${CARGO_PATH}/env" 1&>- 2>&1
        DOTFILES_FEATURES="rust ${DOTFILES_FEATURES}"
    else
        log_error "Rust toolset error: \"${RUST_PATH}\" does not exist. Reinstall rustup and try again."
    fi
}

setup_rust
