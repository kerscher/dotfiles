#!/bin/bash

setup_docker() {
    if command -v docker 2>/dev/null; then
        export DOCKER_CONTENT_TRUST=1
    fi
}

setup_docker
