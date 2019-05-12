load_lib() {
    if test -f "${1}"
    then . "${1}"
    else if command -v log
         then err_msg="Could not load ${1}"
              log error "${err_msg}"
         else echo "[ERROR] ${err_msg}"
              exit 1
         fi
    fi
}
