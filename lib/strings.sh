#!/usr/bin/env bash

trim()
{
    # <doc:trim>
    #
    # Removes all leading/trailing whitespace
    #
    # Usage examples:
    #     echo "  foo  bar baz " | trim  #==> "foo  bar baz"
    #
    # </doc:trim>

    ltrim "$1" | rtrim "$1"
}

ltrim()
{
    # <doc:ltrim>
    #
    # Removes all leading whitespace (from the left).
    #
    # </doc:ltrim>

    local char=${1:-[:space:]}
    sed "s%^[${char//%/\\%}]*%%"
}

rtrim()
{
    # <doc:rtrim>
    #
    # Removes all trailing whitespace (from the right).
    #
    # </doc:rtrim>

    local char=${1:-[:space:]}
    sed "s%[${char//%/\\%}]*$%%"
}

flatten()
{
    # <doc:flatten>
    #
    # Substitute variable names with variables.
    #
    # The default is to try to substitute all environment variables, but if
    # any names are given, it will be limited to just those.
    #
    # The placeholder syntax can be changed by setting the following variables:
    #
    #     FLATTEN_L  # Default: {{
    #     FLATTEN_R  # Default: }}
    #
    # Usage: flatten TEXT [VAR...]
    #
    # </doc:flatten>

    local t=$1; shift
    local n

    local fl=${FLATTEN_L:-\{\{}
    local fr=${FLATTEN_R:-\}\}}

    if (( $# == 0 )); then
        IFS=$'\n' set -- $(set | variables)
    fi

    for n in "$@"; do
        t=${t//${fl}${n}${fr}/${!n}}
    done

    echo "$t"
}

variables()
{
    # <doc:variables>
    #
    # Pulls all variable names from stdin.
    #
    # </doc:variables>

    sed 's/[[:space:];]/\n/g' "$@" |
    egrep '^[a-zA-Z0-9_]+=' |
    sed 's/=.*$//' | sort -u
}
