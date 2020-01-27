#!/bin/bash

: "${HOME?}"
: "${ASDF_HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install Go'
    return
fi

GOLANG_DOTFILES_VERSION='1.13.6'

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
    local -a go_packages=(
        "github.com/astaxie/bat"
        "github.com/golangci/golangci-lint/cmd/golangci-lint"
        "github.com/jessfraz/dockfmt"
        "github.com/liudng/dogo"
        "github.com/mdempsky/gocode"
        "github.com/mitchellh/gox"
        "github.com/segmentio/terraform-docs"
        "github.com/sourcegraph/go-langserver"
        "github.com/svent/sift"
        "golang.org/x/tools/cmd/godoc"
        "golang.org/x/tools/cmd/goimports"
        "golang.org/x/tools/cmd/gorename"
        "golang.org/x/tools/gopls@latest"
    )
    for t in "${go_packages[@]}"
    do go get -u "${t}"
    done
}
