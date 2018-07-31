#!/bin/bash

setup_scala() {
    SBTENV_PATH="${HOME}/.sbtenv/bin"
    if [ -d "${SBTENV_PATH}" ]; then
        export SBTENV_PATH="${SBTENV_PATH}"
        export PATH="${SBTENV_PATH}:${PATH}"
        eval "$(sbtenv init -)"
    else
        log_error "Scala toolset error: \`sbtenv\` is not installed. Install from https://github.com/"
    fi
    SCALAENV_PATH="${HOME}/.scalaenv/bin"
    if [ -d "${SCALAENV_PATH}" ]; then
        export SCALAENV_PATH="${SCALAENV_PATH}"
        export PATH="${SCALAENV_PATH}:${PATH}"
        eval "$(sbtenv init -)"
    else
        log_error "Scala toolset error: \`scalaenv\` is not installed. Install from https://github.com/scalaenv/scalaenv"        
    fi    
}

setup_scala
