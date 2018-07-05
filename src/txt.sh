[ $TXT_SH ] && return || TXT_SH=1

TXT_BIN="printf -- "


### CONSOLE ONLY OUTPUT ###

# Console-only output
function console() {
    ${TXT_BIN} "$1\n"
}

# Console-only output; no newline
function console_n() {
    ${TXT_BIN} "$1"
}

# Displays text highlighted; no new-line
function note() {
    ${TXT_BIN} "\e[94m$1\e[0m"
}

# Displays a highlighted title text; includes a new-line
function title() {
    ${TXT_BIN} "\e[93m$1\e[0m\n"
}


### COMBINED CONSOLE & LOG OUTPUTS ###

# Plain output, includes logging
function out() {
    ${TXT_BIN} "$1\n" 2>&1 | tee -a "${log}"
}

# Plain output; no newline
function out_n() {
    ${TXT_BIN} "$1" 2>&1 | tee -a "${log}"
}


# Displays text in red; no new-line
function err() {
    ${TXT_BIN} "\e[91m$1\e[0m" 2>&1 | tee -a "${log}"
}

# Check status of previous command and return a success/error note
function is_ok() {
    if [[ $? -eq 0 ]]; then
        ${TXT_BIN} " \e[92mOK\e[0m\n" 2>&1 | tee -a "${log}"
    else
        ${TXT_BIN} " \e[91mERROR\e[0m\n" 2>&1 | tee -a "${log}"
    fi
}


### LOG SPECIFIC OUTPUT ###

# Only output to console if verbose logging enabled
function log() {
    if [[ "${VERBOSE}" -eq 1 ]]; then
        ${TXT_BIN} "\e[37m$1\e[0m\n" 2>&1 | tee -a "${log}"
    else
        ${TXT_BIN} "\e[37m$1\e[0m\n" 2>&1 >> "${log}"
    fi
}

# Only output if verbose logging enabled; no new-line
function log_n() {
    if [[ "${VERBOSE}" -eq 1 ]]; then
        ${TXT_BIN} "\e[37m$1\e[0m" 2>&1 | tee -a "${log}"
    else
        ${TXT_BIN} "\e[37m$1\e[0m" 2>&1 >> "${log}"
    fi
}
