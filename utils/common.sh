SCRIPT=`/usr/bin/env python -c "import os; print os.path.realpath('$0')"`
SCRIPTPATH=`dirname $SCRIPT`

# Python virtual-env path
BIN="$SCRIPTPATH/.venv/bin"
ANSIBLE_PLAYBOOK="${BIN}/ansible-playbook"

# Check if virtualenv is initialised
if [ ! -f ".venv/bin/activate" ]
then
    echo "Python virtualenv is not initialised. Please run ./install"
    exit 1
fi

# Check args
if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "  $0 app-name.yml"
    exit 2
fi

# Figure out the AWS profile to use from the project vars file
PROFILE=$(grep 'aws_profile' $1 | tail -n1 | cut -d : -f 2 | awk '{$1=$1;print}');

# Enable the virtual environment
source .venv/bin/activate
