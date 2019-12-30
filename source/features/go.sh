#!/bin/bash

: "${HOME?}"
: "${ASDF_HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Go'
    return
fi

GOLANG_DOTFILES_VERSION='1.13.5'

setup_go() {
    asdf_bootstrap 'golang' "${GOLANG_DOTFILES_VERSION}"

    GO_ASDF_PATH="${ASDF_HOME}/installs/golang/${GOLANG_DOTFILES_VERSION}"
    GOPATH="${GO_ASDF_PATH}/packages"
    GOROOT="${GO_ASDF_PATH}/go"
    GO111MODULE='on'
    export GOPATH GOROOT GO111MODULE

    GOPATH_BIN="${GOPATH}/bin"
    [ -d "${GOPATH_BIN}" ] && export PATH="${GOPATH_BIN}:${PATH}"

    DOTFILES_FEATURES="go ${DOTFILES_FEATURES}"
}

setup_go

install_go_tools() {
    declare -a go_github_packages=(
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
    for t in "${go_github_packages[@]}"; do
        go get -u "github.com/${t}"
    done
}
