#!/bin/bash

if [[ -f /etc/redhat-release ]]; then
    sudo dnf install install \
         cmake \
         ca-certificates \
         curl \
         git \
         docker-latest \
         jq \
         keychain \
         monkeysphere \
         openssl-devel \
         bzip2-devel \
         readline-devel \
         lzma-devel \
         sqlite-devel \
         qrencode \
         zbar \
         oathtool \
         pass \
         pass-otp \
         qtpass
fi

if [[ -f /etc/lsb_release ]]; then   
    sudo add-apt-repository ppa:ubuntu-elisp/ppa
    sudo apt update
    sudo apt dist-upgrade
    sudo apt install \
         build-essential cmake ninja-build \
         ca-certificates \
         curl git \
         docker.io \
         emacs-snapshot \
         jq \
         keychain monkeysphere \
         libssl-dev libsqlite3-dev xorg-dev libbz2-dev libreadline-dev lzma \
         pass \
         tree \
         zbar-tools qrencode oathtool
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
    for t in alecthomas/gometalinter liudng/dogo mitchellh/gox svent/sift; do
        go get -u "github.com/${t}"
    done

    gometalinter --install
}

install_rust_tools() {
    cargo install \
          clog-cli \
          drill \
          funzzy \
          just \
          ripgrep \
          xsv
}

install_haskell_tools() {
    stack install \
          brittany \
          hindent \
          pandoc
}
