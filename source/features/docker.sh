#!/bin/bash

setup_docker() {
    if hash docker 2>/dev/null; then
        export DOCKER_CONTENT_TRUST=1
    fi
    DOTFILES_FEATURES="docker ${DOTFILES_FEATURES}"
}

setup_docker
