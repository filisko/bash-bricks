#!/usr/bin/env bash

db_exists() {
    local db_name="$1"

    if [[ ! -f "$CONFIG_DIR/$db_name" ]]; then
        return 1
    fi
}

load_db() {
    local db_name="$1"

    if [[ -z "$db_name" ]] || [[ ! -f "$CONFIG_DIR/$db_name" ]]; then
        return 1
    fi
    
    source "$CONFIG_DIR/$db_name"
}

# bash -c "help declare"
store_var()
{
    local var=$1;
    local db_name=$2;

    if (( $# == 0 )); then
        IFS=$'\n' set -- $(set | variables)
    fi

    declare -p "${var}" >> "$CONFIG_DIR/$db_name"
}

var_exists() {
    local var_name="$1"
    local db_name="$2"
    
    # db_content=$(cat "$db_name")
    # echo "$db_content"
    db_content=$(cat "$CONFIG_DIR/$db_name")
    # echo "$db_content"

    regex="^declare .. ${var_name}="
    if ! [[ "$db_content" =~ $regex ]]; then
        return 1
    fi
}

remove_var() {
    echo "Test"
}


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

# bb_databases_check
# BB_DATABASES_LOADED=1