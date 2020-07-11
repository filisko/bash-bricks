#!/usr/bin/env bash

in_array()
{
    # <doc:in_array>
    #
    # Determine if a value is in an array.
    #
    # Usage: in_array [VALUE] [ARRAY]
    #
    # </doc:in_array>

    local value=$1; shift
    for item in "$@"; do
        [[ $item == $value ]] && return 0
    done
    return 1
}

join_lines()
{
    # <doc:join_lines>
    #
    # Joins lines from stdin into a string.
    #
    # DELIMITER defaults to ", ".
    #
    # Usage: join_lines [DELIMITER]
    #
    # Usage examples:
    #     echo -e "foo\nbar\nbaz" | join_lines      #==> foo, bar, baz
    #     echo -e "foo\nbar\nbaz" | join_lines "|"  #==> foo|bar|baz
    #
    # </doc:join_lines>

    local delim=${1:-, }

    while read -r; do
        echo -ne "${REPLY}${delim}"
    done | sed "s/$delim$//"
    echo
}

bb_mysql() {
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$AUXMONEY_DB_PASSWORD") \
        -h "$AUXMONEY_DB_IP" \
        -u "$AUXMONEY_DB_USER" \
        -e "$1"
}

bb_mysql_csv() {
    # --disable-column-names \
    # --batch 
    # --silent 
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$AUXMONEY_DB_PASSWORD") \
        --batch \
        -h "$AUXMONEY_DB_IP" \
        -u "$AUXMONEY_DB_USER" \
        -e "$1"
}