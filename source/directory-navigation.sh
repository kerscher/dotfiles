#!/bin/bash

change_directory() {
    if hash cdargs 2>/dev/null; then
        cdargs "$1" && pushd "$(cat "$HOME/.cdargsresult")"
    else
        log_error "Error: cdargs is not on PATH. Ensure it's installed and try again."
    fi
}