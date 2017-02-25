`dotfiles`
----------

[![Build Status](https://travis-ci.org/kerscher/dotfiles.svg?branch=master)](https://travis-ci.org/kerscher/dotfiles)
![BSD3 license](https://img.shields.io/badge/licence-BSD%202--clause-blue.svg)

![If you could only see this image…](images/the-other-guy-is-picking-his-nose.gif)

```shell
git clone git@github.com:kerscher/dotfiles
ln -s $(pwd)/dotfiles/source ${HOME}/.dotfiles
cat << EOF > ${HOME}/.bashrc
source ${HOME}/.dotfiles/init.sh
EOF
exec ${SHELL}
```

## Licence

This repository uses a 2-clause BSD-like licence. You can check it [here](LICENCE.md).
