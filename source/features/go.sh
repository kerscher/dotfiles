#!/bin/bash

: "${HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Go'
    return
fi

GOLANG_DOTFILES_VERSION='1.13'

setup_go() {
    asdf_bootstrap 'golang' "${GOLANG_DOTFILES_VERSION}"
    
    GOPATH="${HOME}/go"
    if [ ! -d "${GOPATH}" ]; then
        mkdir "${GOPATH}"
        export GOPATH="${GOPATH}"
    fi
    export PATH=${GOPATH}/bin:${PATH}
    DOTFILES_FEATURES="go ${DOTFILES_FEATURES}"
}

setup_go

install_go_tools() {
    declare -a go_packages=(
        "astaxie/bat"
        "golangci/golangci-lint/cmd/golangci-lint"
        "jessfraz/dockfmt"
        "liudng/dogo"
        "mdempsky/gocode"
        "mitchellh/gox"
        "segmentio/terraform-docs"
        "sourcegraph/go-langserver"
        "svent/sift"
    )
    for t in "${go_packages[@]}"; do
        go get -u "github.com/${t}"
    done
}
