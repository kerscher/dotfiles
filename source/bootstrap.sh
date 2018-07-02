#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ -f /etc/redhat-release ]]; then
    declare -a fedora_packages=(
         "bzip2-devel"
         "bzip2-devel"
         "ca-certificates"
         "cmake"
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
         "lzma-devel"
         "lzma-devel"
         "monkeysphere"
         "oathtool"
         "openssl-devel"
         "pass"
         "pass-otp"
         "qrencode"
         "qtpass"
         "readline-devel"
         "readline-devel"
         "sqlite-devel"
         "tilda"
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
         "ca-certificates"
         "curl"
         "docker.io"
         "emacs-snapshot"
         "git"
         "jq"
         "keychain"
         "libbz2-dev"
         "libreadline-dev"
         "libsqlite3-dev"
         "libssl-dev"
         "lzma"
         "monkeysphere"
         "oathtool"
         "pass"
         "qrencode"
         "tree"
         "xorg-dev"
         "zbar-tools"
        "build-essential"
        "cmake"
        "ninja-build"
    )

    sudo add-apt-repository ppa:ubuntu-elisp/ppa
    sudo apt update
    sudo apt dist-upgrade
    sudo apt install "${ubuntu_packages[@]}"
fi

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
git clone https://github.com/kamatama41/tfenv.git ~/.tfenv
git clone https://github.com/syndbg/goenv.git ~/.goenv
curl https://sh.rustup.rs -sSf | sh
curl -sSL https://get.haskellstack.org/ | sh

sudo git clone https://github.com/9fans/plan9port /usr/local/plan9 
sudo chown -R "${USER}:${USER}" /usr/local/plan9
pushd /usr/local/plan9
./INSTALL
popd

install_go_tools() {
    declare -a go_packages=(
        "alecthomas/gometalinter"
        "astaxie/bat"
        "jessfraz/dockfmt"
        "liudng/dogo"
        "mitchellh/gox"
        "svent/sift"
    )
    for t in "${go_packages[@]}"; do
        go get -u "github.com/${t}"
    done

    gometalinter --install
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
        "brittany"
        "hindent"
        "pandoc"
        "ShellCheck"
        "hlint"
    )

    stack install "${haskell_packages[@]}"
}
