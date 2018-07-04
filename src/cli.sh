[ $CLI_SH ] && return || CLI_SH=1

source "${app}/src/txt.sh"


# CLI help screen
function help_scr() {
    title "${name}"
    echo -n "Version "; note "${version}"; echo
    echo
    echo "Usage:"
    echo "  $0 [args] [command]"
    echo
    echo "Arguments:"
    echo "   --log fn               Use a different logging location (default ~/.docker-aws/log)"
    echo "   --venv fn              Use a different location for the virtual environment (default ~/.docker-aws/venv)"
    echo "   --version              Display current version"
    echo "   -v --verbose           Increase logging output"
    echo
    echo "Commands:"
    echo "   setup                  Configure the virtual environment"
    echo "   create                 Create a new project"
    echo "   launch fn              Launch application found in profile 'fn'"
    echo "   teardown fn            Teardown application found in profile 'fn'"
    echo "   help                   Display this help screen"
    echo
}

# Parse the command line
function cli_parse() {
    # No args is invalid, show help and exit
    if [[ $# -eq 0 ]]; then
        help_scr
        exit 1
    fi

    # CLI parser
    while [ -n "$1" ]; do
        case "$1" in
            setup)
                source "${app}/src/venv/setup.sh"
                venv_setup
                shift
                ;;
            launch)
                source "${app}/src/ansible/exec.sh"
                daws_launch "$2"
                shift 2
                ;;
            teardown)
                source "${app}/src/ansible/exec.sh"
                daws_teardown "$2"
                shift 2
                ;;
            help|--help|'-?')
                help_scr
                check_for_updates
                shift
                ;;
            -v|--verbose)
                VERBOSE=1
                shift
                ;;
            --version)
                echo "${version}"
                shift
                ;;
            --venv)
                venv="$2"
                shift 2
                ;;
            --log)
                log="$2"
                shift 2
                ;;
            --)
                exit 0
                ;;
            *)
                echo -n "Unknown command line option '"; note "$1"; echo "'"
                exit 1
                ;;
        esac
    done
}
