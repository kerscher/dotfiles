#!/bin/bash

setup_google_cloud() {
    if [ -d "${HOME}/.local/share/google-cloud-sdk/" ]; then
        GCLOUD_ROOT="${HOME}/.local/share/google-cloud-sdk"
        # shellcheck source=/dev/null
        source "${GCLOUD_ROOT}/path.bash.inc"
        # shellcheck source=/dev/null
        source "${GCLOUD_ROOT}/completion.bash.inc"
        DOTFILES_FEATURES="googlecloud ${DOTFILES_FEATURES}"
    else
        log_error "Google Cloud SDK error: not found! Install in ${HOME}/.local/share/google-cloud-sdk/"
    fi
}

setup_google_cloud
