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


install_package() {
    if is_linux; then
        sudo apt-get install -y "$1"
    fi

    if is_osx && ! binary_exists "brew"; then
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

binary_exists() {
    if ! which "$1" > /dev/null; then
        return 1
    fi
}

bb_packages_check() {
    if ! is_linux && ! is_osx; then
        echo "your Operating System is not supported, remove do not load packages module please"
        exit 1
    fi

    if (is_linux) && (! binary_exists "apt-get" || ! binary_exists "dpkg-query"); then
        echo "install apt-get (debian/ubuntu)  to be able to use packages helpers"
        exit 1
    fi

    if is_osx && ! binary_exists "brew" > /dev/null; then
        echo "install brew to be able to use packages helpers https://brew.sh/"
        exit 1
    fi
}

bb_packages_check
BB_PACKAGES_LOADED=1