[ $VENV_SETUP_SH ] && return || VENV_SETUP_SH=1

source "${app}/src/txt.sh"
source "${app}/src/venv/common.sh"


function venv_setup() {
    log "Install venv: ${venv}"

    # Setup python virtual-env for setting up dependencies
    note "Checking virtualenv installation.."
    sudo -H pip install -qIU --no-warn-conflicts virtualenv
    is_ok

    # Create a python virtual environment
    note "Creating virtual environment.."
    virtualenv -q "${venv}"
    is_ok

    # Enable the virtual environment
    note "Activating environment.."
    venv_activate
    is_ok

    # Then install with pip will be inside that virtual environment
    note "Installing requirements.."
    pip install -qIr "${app}/var/pip-requirements.txt"
    is_ok
}
