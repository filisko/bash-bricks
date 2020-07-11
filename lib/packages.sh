#!/usr/bin/env bash

is_linux() {
    if [[ "$OSTYPE" == "linux"* ]]; then
        return 0
    fi

    return 1
}

is_osx() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    fi
    return 1
}

check_package_manager() {
    if ! is_linux && ! is_osx; then
        echo "your Operating System is not supported"
        exit 1
    fi

    if (is_linux) && (! which apt-get > /dev/null || ! which dpkg-query > /dev/null); then
        echo "install apt-get (debian/ubuntu)  to be able to use packages helpers"
        exit 1
    fi

    if is_osx && ! which brew > /dev/null; then
        echo "install brew to be able to use packages helpers https://brew.sh/"
        exit 1
    fi
}

install_package() {
    if is_linux; then
        sudo apt-get install -y "$1"
    fi

    if is_osx && ! which brew > /dev/null; then
        brew install "$1"
    fi
}

is_package_installed() {
    if is_linux && ! dpkg-query -l | grep "$1" > /dev/null; then
        return 1
    fi

    if is_osx && ! brew ls --versions "$1" > /dev/null; then
        return 1
    fi
}

check_package_manager