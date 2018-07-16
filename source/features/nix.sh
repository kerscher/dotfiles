#!/bin/bash

setup_nix() {
    NIX_PROFILE_SH="${HOME}/.nix-profile/etc/profile.d/nix.sh"
    if [ -e "${NIX_PROFILE_SH}" ]; then
        # shellcheck source=/dev/null
        . "${NIX_PROFILE_SH}";
    fi
    unset NIX_PROFILE_SH
}

