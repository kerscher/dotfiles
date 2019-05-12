#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${SCRIPT_DIR}/lib/load.sh"
declare -a dependencies=(
    "${SCRIPT_DIR}/lib/log.sh"
    "${SCRIPT_DIR}/lib/tty.sh"
    "${SCRIPT_DIR}/lib/paths.sh"
)
for dep in "${dependencies[@]}"
do load_lib "${dep}"
done

export PATH="$(paths get_default)"

if is_terminal
then
    declare -a interactive_dependencies=(
        "${SCRIPT_DIR}/lib/history_control.sh"
    )
    for dep in "${interactive_dependencies[@]}"
    do load_lib "${dep}"
    done

    history_control set_shell_options
    log info 'Setup pager preprocessor'
    log info 'Setup documentation'
    log info 'Setup prompt'
    log info 'Add completions'
fi
