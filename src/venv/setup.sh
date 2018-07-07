[ $VENV_SETUP_SH ] && return || VENV_SETUP_SH=1

source "${app}/src/txt.sh"
source "${app}/src/os.sh"
source "${app}/src/venv/common.sh"


function venv_setup() {
    log "Install venv: ${venv}"

    # Check if pip is available
    out_n "Checking python-pip is installed.."
    if [[ ! $(command -v pip) ]]; then
        err "PIP package manager needs to be installed. Aborting."
        err "http://pip.pypa.io/en/stable/installing/"
        exit
    fi
    is_ok

    # Detect OS family to run PIP as user or root
    out_n "Checking OS family: "
    detect_os
    out_n "${os_family} detected.."
    is_ok

    # Setup python virtual-env for setting up dependencies
    out_n "Checking virtualenv installation.."
    if [[ "${os_family}" eq "OSX" ]]; then
        pip install -qIU --no-warn-conflicts --user virtualenv
    elif 
        sudo pip install -qIU --no-warn-conflicts virtualenv
    fi
    is_ok

    if [[ -d "${venv}" ]]; then
        out_n "Removing previous virtual environment.."
        rm -rf "${venv}"
        is_ok
    fi

    # Create a python virtual environment
    out_n "Creating virtual environment.."
    virtualenv -q "${venv}"
    is_ok

    # Enable the virtual environment
    out_n "Activating environment.."
    venv_activate
    is_ok

    # Then install with pip will be inside that virtual environment
    out_n "Installing requirements.."

    # The ignore warnings is to squelch the InsecurePlatformWarnings that happen on some versions of Python
    PYTHONWARNINGS="ignore" \
    pip install -qIr "${app}/var/pip-requirements.txt"
    is_ok
}
