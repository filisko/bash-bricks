#!/usr/bin/env bash

bb_mysql() {
    port=${DB_PORT:-3306}
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$DB_PASSWORD") \
        -h "$DB_HOST" \
        -P "$port" \
        -u "$DB_USER" \
        -e "$1"
}

bb_mysql_raw() {
    port=${DB_PORT:-3306}
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$DB_PASSWORD") \
        --batch \
        -N \
        --disable-column-names \
        -h "$DB_HOST" \
        -P "$port" \
        -u "$DB_USER" \
        -e "$1"
}

bb_databases_check() {
    if [[ -z "$BB_COMMON_LOADED" ]]; then
        echo "common.sh must be loaded before databases.sh"
        exit 1
    fi

    if ! binary_exists "mysql"; then
        echo "Install mysql for mysql binary to be available"
        exit 1
    fi

    if [[ -z "$DB_HOST" ]] || [[ -z "$DB_USER" ]] || [[ -z "$DB_PASSWORD" ]]; then
        echo "Please configure DB_HOST, DB_USER, DB_PASSWORD and DB_PORT (this one optional) on your env file."
        exit 1
    fi
}

bb_databases_check
BB_DATABASES_LOADED=1