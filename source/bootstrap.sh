#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

echo 'dotfiles: bootstrapping system packages. You will be asked for super-user permissions.'

if [[ -f /etc/redhat-release ]]; then
    declare -a fedora_packages=(
        "autoconf"
        "automake"
        "bzip2"
        "bzip2-devel"
        "ca-certificates"
        "cmake"
        "curl"
        "dnf-plugins-core"
        "emacs"
        "fontconfig-devel"
        "freetype-devel"
        "gcc"
        "git"
        "jq"
        "keychain"
        "libXext-devel"
        "libXt-devel"
        "libffi-devel"
        "libicu-devel"
        "libtool"
        "libxslt-devel"
        "libyaml-devel"
        "lzma-devel"
        "make"
        "monkeysphere"
        "ncurses-compat-libs"
        "ncurses-devel"
        "oathtool"
        "openssl-devel"
        "pass"
        "pass-otp"
        "qrencode"
        "qtpass"
        "readline-devel"
        "sqlite"
        "sqlite-devel"
        "tilda"
        "tk-devel"
        "unixODBC-devel"
        "unzip"
        "xorg-x11-server-devel"
        "xz"
        "zbar"
        "zlib-devel"
    )
    sudo dnf install "${fedora_packages[@]}"
    sudo dnf config-manager \
         --add-repo \
         https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install docker-ce
fi

if [[ -f /etc/lsb-release ]]; then
    declare -a ubuntu_packages=(
        "autoconf"
        "automake"
        "build-essential"
        "ca-certificates"
        "cmake"
        "curl"
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
        "liblzma-dev"
        "libncurses-dev"
        "libncurses5-dev"
        "libreadline-dev"
        "libsqlite3-dev"
        "libssl-dev"
        "libtinfo-dev"
        "libtool"
        "libxml2-dev"
        "libxmlsec1-dev"
        "libxslt-dev"
        "libyaml-dev"
        "llvm"
        "lzma"
        "make"
        "monkeysphere"
        "ninja-build"
        "oathtool"
        "pass"
        "qrencode"
        "tk-dev"
        "tree"
        "unixodbc-dev"
        "unzip"
        "wget"
        "xorg-dev"
        "xz-utils"
        "zbar-tools"
        "zlib1g-dev"
    )
    sudo add-apt-repository ppa:ubuntu-elisp/ppa
    sudo apt update
    sudo apt dist-upgrade
    sudo apt install "${ubuntu_packages[@]}"
fi
