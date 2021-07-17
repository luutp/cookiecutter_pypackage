#!/bin/bash
# -------------------------------------DEFINE---------------------------------------
WORKSPACE_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd )"
PROJECT_NAME="${PWD##*/}"
# ----------------------------------INCLUDE---------------------------------------
source $WORKSPACE_FOLDER/.vscode/print.sh
CONDA_DIR="$HOME/Anaconda3"
export PATH=${CONDA_DIR}/Scripts:$PATH
source ${CONDA_DIR}/etc/profile.d/conda.sh
PIP_REQUIREMENTS=$WORKSPACE_FOLDER/requirements.txt

# Get Conda Env Name
if [ "$1" != "" ]; then
    CONDA_ENV="$1"
else
    print "Select Conda Environment:"
    read CONDA_ENV
fi
conda activate
print "conda version: $(conda --version)"
print "Setup Conda $CONDA_ENV Environment"
# ======================================================================================
# Create Conda environment
## Add Anaconda to PATH and update
if [[ -d "${CONDA_DIR}/envs/${CONDA_ENV}" ]]; then
    print "${CONDA_ENV} Exist"
else
    print "conda create -y -n ${CONDA_ENV} python=3.7"
    conda create -y -n $CONDA_ENV python=3.7
    conda env list
fi
# Activate
conda activate $CONDA_ENV
# pip install
cd ${WORKSPACE_FOLDER}
print "Installing PIP requirements"
${CONDA_DIR}/envs/${CONDA_ENV}/Scripts/pip install -r $PIP_REQUIREMENTS