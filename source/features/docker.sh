#!/bin/bash

setup_docker() {
    if command -v docker > /dev/null 2>&1; then
        export DOCKER_CONTENT_TRUST=1
    fi
}

setup_docker
