#!/bin/bash
# DEFINES
CLEAR="\e[0m"
BOLD="\e[1m"
UNDERLINE="\e[4m"
BLINK="\e[5m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
# -------------------------------------START---------------------------------------
function print(){
    if [[ "$#" == 1 ]]; then
        echo -e "$MAGENTA $1 $CLEAR"
    else
        echo -e "$1 $2 $CLEAR"
    fi
}

function print_warning(){
    if [[ "$#" == 1 ]]; then
        echo -e "$YELLOW Warning: $1 $CLEAR"
    else
        echo -e "$1 $2 $CLEAR"
    fi
}

function print_error(){
    if [[ "$#" == 1 ]]; then
        echo -e "$RED Error: $1 $CLEAR"
    else
        echo -e "$1 $2 $CLEAR"
    fi
}