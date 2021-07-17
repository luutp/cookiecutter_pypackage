#!/bin/bash
# -------------------------------------DEFINE---------------------------------------
WORKSPACE_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd )"
# Get project name from path (basename)
PROJECT_NAME="${PWD##*/}"
CONDA_DIR="$HOME/Anaconda3"
CONDA_ENV="flaskweb"
# -------------------------------------INCLUDE---------------------------------------
source $WORKSPACE_FOLDER/.vscode/print.sh
export PATH=${CONDA_DIR}/Scripts:$PATH
source ${CONDA_DIR}/etc/profile.d/conda.sh

PYTHON_FILENAME=""
# Display help message
USAGE="$(basename "$0") [-f|--filename]

Description

Requirements: Anaconda3, python 3.7

Args:
    -h|--help       Show this help message
    -f|--filename	python filename
"
# Arguments parser
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) show_help=true ;;
        -f|--filename) PYTHON_FILENAME="$2"; shift ;;
        *) print "Unknown argument: $1"; exit 1 ;;
    esac
    shift
done

if [[ $show_help == true ]]; then
    print "$USAGE"
    exit
fi

# -------------------------------------START---------------------------------------

if [[ -z "$PYTHON_FILENAME" ]]; then
    print_error "python filename must be provided"
    exit 1
else
    PYTHON_FILEPATH=${WORKSPACE_FOLDER}/.vscode/${PYTHON_FILENAME}
    conda activate
    # Activate
    conda activate $CONDA_ENV
    print $(which python)
    print "Running: ${PYTHON_FILEPATH}"
    python ${PYTHON_FILEPATH}
fi