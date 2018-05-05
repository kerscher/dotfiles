#!/bin/bash

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
