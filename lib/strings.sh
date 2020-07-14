#!/usr/bin/env bash

camel()
{
    # <doc:camel>
    #
    # Make text from stdin camel case.
    #
    # </doc:camel>

    sed 's/_/ /g' |
    sed 's/\<\(.\)/\U\1/g' |
    sed 's/ //g'
}

snake()
{
    # <doc:snake>
    #
    # Make text from stdin snake case.
    #
    # </doc:snake>

    sed 's/\([[:upper:]]\)/ \1/g' | detox
}

title()
{
    # <doc:title>
    #
    # Convert stdin to titlecase.
    #
    # </doc:title>

    lower | sed 's/\<./\u&/g' |
    sed "s/'[[:upper:]]/\L&\l/g"
}

detox()
{
    # <doc:detox>
    #
    # Make text from stdin slightly less insane.
    #
    # </doc:detox>

    sed 's/[^A-Za-z0-9 ]/ /g' |
    squeeze | sed 's/ /_/g' | lower
}

squeeze()
{
    # <doc:squeeze>
    #
    # Removes leading/trailing whitespace and condenses all other consecutive
    # whitespace into a single space.
    #
    # Usage examples:
    #     echo "  foo  bar   baz  " | squeeze  #==> "foo bar baz"
    #
    # </doc:squeeze>

    local char=${1:-[[:space:]]}
    sed "s%\(${char//%/\\%}\)\+%\1%g" | trim "$char"
}

lower()
{
    # <doc:lower>
    #
    # Convert stdin to lowercase.
    #
    # </doc:lower>

    tr '[:upper:]' '[:lower:]'
}

upper()
{
    # <doc:upper>
    #
    # Convert stdin to uppercase.
    #
    # </doc:upper>

    tr '[:lower:]' '[:upper:]'
}

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

lines()
{
    # <doc:lines>
    #
    # Get all lines except for comments and blank lines.
    #
    # Usage: lines [FILE...]
    #
    # </doc:lines>

    grep -E -v '^[[:space:]]*#|^[[:space:]]*$' "$@"
}
