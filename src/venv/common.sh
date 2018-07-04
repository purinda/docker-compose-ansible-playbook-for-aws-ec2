[ $VENV_COMMON_SH ] && return || VENV_COMMON_SH=1

source "${app}/src/txt.sh"


function venv_activate() {
    # Check if virtualenv is initialised
    if [ ! -f "${venv}/bin/activate" ]
    then
        err "Python virtualenv is not initialised. Please run the setup command first."
        return 1
    fi

    source "${venv}/bin/activate"
    return $?
}
