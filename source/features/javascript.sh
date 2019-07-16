#!/bin/bash

: "${HOME?}"
: "${DOTFILES?}"
: "${ASDF_HOME?}"

if ! test "$(type -t asdf_bootstrap = 'function')"
then
    log_error 'You need asdf_bootstrap to install javascript'
    return
fi

NODEJS_DOTFILES_VERSION='12.6.0'

setup_javascript() {
    local NODEJS_KEYRING_IMPORTED="${DOTFILES}/status/nodejs-keyring-imported"
    if [ ! -f "${NODEJS_KEYRING_IMPORTED}" ]
    then
        NODEJS_PLUGIN_IMPORT="${ASDF_HOME}/plugins/nodejs/bin/import-release-team-keyring"
        if [ -x "${NODEJS_PLUGIN_IMPORT}" ]
        then
            bash "${NODEJS_PLUGIN_IMPORT}" \
                && touch "${NODEJS_KEYRING_IMPORTED}"
        else
            KEYS="94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
                  FD3A5288F042B6850C66B31F09FE44734EB7990E \
                  71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
                  DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
                  C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
                  B9AE9905FFD7803F25714661B63B535A4C206CA9 \
                  8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
                  77984A986EBC2AA786BC0F66B01FBB92821C587A \
                  A48C2BEE680E841632CD4E44F07496B3EB3C1762 \
                  4ED778F539E3634C779C87C6D7062848A1AB005C \
                  B9E2F5981AA6E0CD28160D9FF13993A75599653C"
            SERVERS="ha.pool.sks-keyservers.net
                     p80.pool.sks-keyservers.net:80 \
                     ipv4.pool.sks-keyservers.net \
                     keyserver.ubuntu.com
                     keyserver.ubuntu.com:80 \
                     pgp.mit.edu
                     pgp.mit.edu:80"
            local OPTIONS=""
            if [ -n "${http_proxy:-}" ]
            then OPTIONS="--keyserver-options http-proxy=${http_proxy}"
            fi
            for key in ${KEYS}; do
                for server in ${SERVERS}; do
                    gpg --no-tty \
                        --keyserver "hkp://$server" \
                        \ # shellcheck disable=SC2086
                        ${OPTIONS} \
                        --display-charset utf-8 \
                        --recv-keys "${key}" \
                        && break
                done
            done
        fi
    fi
    asdf_bootstrap 'nodejs' "${NODEJS_DOTFILES_VERSION}"
    DOTFILES_FEATURES="javascript ${DOTFILES_FEATURES}"
}

setup_javascript
