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
