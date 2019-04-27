#!/bin/bash

text_editor() {
    if command -v emacsclient 2>/dev/null; then
        # If EDITOR is unset, emacsclient will launch emacsdaemon.
        echo "emacsclient --create-frame --alternate-editor=${EDITOR}"
    elif command -v mg 2>/dev/null; then
        echo "mg"
    elif [ ! -z "${EDITOR}" ]; then
        echo "${EDITOR}"
    else
        echo "vi"
    fi
}
