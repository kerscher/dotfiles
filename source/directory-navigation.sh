#!/bin/bash

set -B

change_directory() {
    if command -v cdargs> /dev/null 2>&1; then
        cdargs "$1" && pushd "$(cat "$HOME/.cdargsresult")" || exit
    else
        log_error "Error: cdargs is not on PATH. Ensure it's installed and try again."
    fi
}
