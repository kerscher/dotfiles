#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ -f /etc/redhat-release ]]; then
    declare -a fedora_packages=(
        "autoconf"
        "automake"
        "bzip2-devel"
        "bzip2-devel"
        "ca-certificates"
        "cmake"
        "curl"
        "curl"
        "dnf-plugins-core"
        "emacs"
        "fontconfig-devel"
        "freetype-devel"
        "git"
        "jq"
        "keychain"
        "libXext-devel"
        "libXt-devel"
        "libffi-devel"
        "libffi-devel"
        "libicu-devel"
        "libtool"
        "libxslt-devel"
        "libyaml-devel"
        "lzma-devel"
        "lzma-devel"
        "monkeysphere"
        "ncurses-compat-libs"
        "ncurses-devel"
        "oathtool"
        "openssl-devel"
        "openssl-devel"
        "pass"
        "pass-otp"
        "qrencode"
        "qtpass"
        "readline-devel"
        "readline-devel"
        "readline-devel"
        "sqlite-devel"
        "tilda"
        "unixODBC-devel"
        "unzip"
        "xorg-x11-server-devel"
        "zbar"
    )
    sudo dnf install "${fedora_packages[@]}"
    sudo dnf config-manager \
         --add-repo \
         https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install docker-ce
fi

if [[ -f /etc/lsb_release ]]; then
    declare -a ubuntu_packages=(
        "autoconf"
        "automake"
        "build-essential"
        "ca-certificates"
        "cmake"
        "curl"
        "curl"
        "docker.io"
        "emacs-snapshot"
        "git"
        "jq"
        "keychain"
        "libbz2-dev"
        "libffi-dev"
        "libicu-dev"
        "libncurses-dev"
        "libreadline-dev"
        "libreadline-dev"
        "libsqlite3-dev"
        "libssl-dev"
        "libssl-dev"
        "libtinfo-dev"
        "libtool"
        "libxslt-dev"
        "libyaml-dev"
        "lzma"
        "monkeysphere"
        "ninja-build"
        "oathtool"
        "pass"
        "qrencode"
        "tree"
        "unixodbc-dev"
        "unzip"
        "xorg-dev"
        "zbar-tools"
    )
    sudo add-apt-repository ppa:ubuntu-elisp/ppa
    sudo apt update
    sudo apt dist-upgrade
    sudo apt install "${ubuntu_packages[@]}"
fi

curl https://sh.rustup.rs -sSf | sh
curl -sSL https://get.haskellstack.org/ | sh

sudo git clone https://github.com/9fans/plan9port /usr/local/plan9
sudo chown -R "${USER}:${USER}" /usr/local/plan9
pushd /usr/local/plan9
./INSTALL
popd

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

install_rust_tools() {
    declare -a rust_packages=(
        "clog-cli"
        "drill"
        "funzzy"
        "just"
        "ripgrep"
        "xsv"
    )
    cargo install "${rust_packages[@]}"
}

install_haskell_tools() {
    declare -a haskell_packages=(
        "hindent"
        "pandoc"
        "ShellCheck"
        "hlint"
    )
    stack install "${haskell_packages[@]}"
}

install_python_tools() {
    declare -a python_packages=(
        "black"
        "isort"
        "mccabe"
        "mypy"
        "pycodestyle"
        "pydocstyle"
        "pyflakes"
        "pygments"
        "pyls-black"
        "pyls-isort"
        "pyls-mypy"
        "python-language-server[all]"
        "rope"
    )
    pip install --upgrade pip setuptools
    pip install --upgrade "${python_packages[@]}"
}
