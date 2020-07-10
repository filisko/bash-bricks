#!/usr/bin/env bash
# Determine if we're interactive or not
is_tty() { test -t 1; }

# only output colors if our output is to terminal
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
if is_tty; then
    GREEN="\033[0;32m"
    RED="\033[0;31m"
    YELLOW="\033[0;33m"
    CYAN="\033[0;96m"
    BOLD_WHITE="\033[1;37m"
    BOLD_GREEN="\033[1;32m"
    BOLD_MAGENTA="\033[1;95m"
    CLEAR="\033[0m"
else
    GREEN=""
    RED=""
    YELLOW=""
    CYAN=""
    BOLD_WHITE=""
    BOLD_GREEN=""
    BOLD_MAGENTA=""
    CLEAR=""
fi

# ANSI color output helpers
green() { echo -en "${GREEN}"$@"${CLEAR}"; }
red() { echo -en "${RED}"$@"${CLEAR}"; }
yellow() { echo -en "${YELLOW}"$@"${CLEAR}"; }
cyan() { echo -en "${CYAN}"$@"${CLEAR}"; }
bold() { echo -en "${BOLD_WHITE}"$@"${CLEAR}"; }
bold_magenta() { echo -en "${BOLD_MAGENTA}"$@"${CLEAR}"; }
bold_green() { echo -en "${BOLD_GREEN}"$@"${CLEAR}"; }
normal() { echo -en "${CLEAR}"$@"${CLEAR}"; }

success() {
    local check="✔"
    green $check
    echo -e "\012" # white space
}

error() {
    local x="✘"
    red $x
    echo -e "\012" # white space
}
# echo $(error; yellow "My warning!")

# DIRS
readonly CORE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly LIB_DIR="$(cd "$(dirname $CORE_DIR/../../)"; pwd -P)"
readonly PROJECT_DIR="$(cd "$(dirname $LIB_DIR/../../)"; pwd -P)"
readonly CONFIG_DIR="$PROJECT_DIR/config"

# loads .env
if [ ! -f "$CONFIG_DIR/.env" ]; then
    echo "Create $CONFIG_DIR/.env"
    exit 1
fi

# make .env variables global for every script
if [ -f "$CONFIG_DIR/.env" ]; then
  export $(cat "$CONFIG_DIR/.env" | sed 's/#.*//g' | xargs)
fi

source "$CORE_DIR/lib/http.sh"
source "$CORE_DIR/lib/notifications.sh"
source "$CORE_DIR/lib/validations.sh"