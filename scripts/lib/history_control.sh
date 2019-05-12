history_control() {
    show_usage()(
        echo "[ERROR] history_control { set_shell_options sync }"
    ) >&2
    is_valid_arg()( test "$(type -t "${1}")" = 'function' )

    sync_history() (
        history -n && \
        history -w && \
        history -c && \
        history -r
    )
    set_shell_options() (
        HISTCONTROL='ignoreboth:erasedups'
        HISTSIZE=1000
        HISTFILESIZE=2000
        export HISTCONTROL HISTSIZE HISTFILESIZE
        shopt -s histappend
        shopt -s extglob
        PROMPT_COMMAND="sync_history; ${PROMPT_COMMAND:-}"
    )

    if is_valid_arg "${1}"
    then "${1}"
    else show_usage
    fi
}
