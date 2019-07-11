#!/bin/bash

if hash man 2>/dev/null; then
    LOCAL_MAN="${LOCAL_PATH}/share/man"
    MANPATH=$LOCAL_MAN:$MANPATH
    export LOCAL_MAN MANPATH
fi

if hash info 2>/dev/null; then
    LOCAL_INFO="${LOCAL_PATH}/share/info"
    INFOPATH=$LOCAL_INFO:$INFOPATH
    export LOCAL_INFO INFOPATH
fi

[ -x /usr/bin/lesspipe ] \
    && eval "$(SHELL=/bin/sh lesspipe)"
