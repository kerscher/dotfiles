#!/bin/bash

text_editor() {
    if command -v emacsclient > /dev/null 2>&1; then
        # If EDITOR is unset, emacsclient will launch emacsdaemon.
        echo "emacsclient --create-frame --alternate-editor=${EDITOR}"
    elif command -v mg > /dev/null 2>&1; then
        echo "mg"
    elif [ ! -z "${EDITOR}" ]; then
        echo "${EDITOR}"
    else
        echo "vi"
    fi
}
