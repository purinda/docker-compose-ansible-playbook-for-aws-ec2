[ $TXT_SH ] && return || TXT_SH=1

# Check status of previous command and return a success/error note
function is_ok() {
    if [[ $? -eq 0 ]]; then
        echo -e " \e[92mOK\e[0m"
    else
        echo -e " \e[91mERROR\e[0m"
    fi
}

# Displays text highlighted; no new-line
function note() {
    echo -en "\e[94m$1\e[0m"
}

# Displays a highlighted title text; includes a new-line
function title() {
    echo -e "\e[93m$1\e[0m"
}

# Displays text in red; no new-line
function err() {
    echo -en "\e[91m$1\e[0m"
}

# Only output if verbose logging enabled
function log() {
    if [[ "${VERBOSE}" -eq 1 ]]; then
        echo -e "\e[37m$1\e[0m"
    fi
}

# Only output if verbose logging enabled; no new-line
function log_n() {
    if [[ "${VERBOSE}" -eq 1 ]]; then
        echo -en "\e[37m$1\e[0m"
    fi
}
