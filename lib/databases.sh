#!/usr/bin/env bash

db_exists() {
    local db_name="$1"
    local db_path="$(get_db_path "$db_name")"

    if [[ ! -f "$db_path" ]]; then
        return 1
    fi
}

load_db() {
    local db_name="$1"
    local db_path="$(get_db_path "$db_name")"

    echo eval " \
  if [ -r '$db_path' ] ; then \
    source '$db_path' ; \
  fi \
";
}

create_db() {
    local db_name="$1"
    local db_path="$(get_db_path "$db_name")"

    touch "$db_path"
}

get_db_path() {
    local db_name="$1"

    printf "$DATABASES_DIR/${db_name}.vars.sh"
}

remove_db() {
    echo "removed"
}

# bash -c "help declare"
store_var() {
    local var_name=$1
    local db_name="$2"

    if ! db_exists "$db_name"; then
        create_db "$db_name"
        bb_log "'$db_name' database has been created" "INFO"
    fi

    if (( $# == 0 )); then
        IFS=$'\n' set -- $(set | variables)
    fi

    if ! declare -p "$var_name" &> /dev/null; then
        return 1
    fi

    if var_is_stored "$var_name" "$db_name"; then
        remove_var "$var_name" "$db_name"
    fi
    
    local db_path="$(get_db_path "$db_name")"
    declare -p "$var_name" >> "$db_path"
}

var_is_stored() {
    local var_name="$1"
    local db_name="$2"
    local db_path="$(get_db_path "$db_name")"
    local db_content=$(cat "$db_path")
    local regex="declare .. ${var_name}="
    
    if ! [[ $db_content =~ $regex ]]; then
        return 1
    fi
}

remove_var() {
    local var_name="$1"
    local db_name="$2"
    local db_path="$(get_db_path "$db_name")"
    local db_path_tmp="$db_path.tmp"
    local regex="declare .. ${var_name}="

    while read -r line; do
        [[ ! $line =~ $regex ]] && echo "$line"
    done <"$db_path" > "$db_path_tmp"

    mv "$db_path_tmp" "$db_path"
}


bb_mysql() {
    local port=${DB_PORT:-3306}
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$DB_PASSWORD") \
        -h "$DB_HOST" \
        -P "$port" \
        -u "$DB_USER" \
        -e "$1"
}

bb_mysql_raw() {
    local port=${DB_PORT:-3306}
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