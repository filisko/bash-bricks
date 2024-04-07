#!/usr/bin/env bash

# redefinable
bb_mysql_get_host() {
    echo $DB_HOST;
}

# redefinable
bb_mysql_get_port() {
    local port=${DB_PORT:-3306}
    echo $port;
}

# redefinable
bb_mysql_get_user() {
    echo $DB_USER;
}

# redefinable
bb_mysql_get_password() {
    echo $DB_PASSWORD;
}

bb_mysql_check() {
    local port=${DB_PORT:-3306}

    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$(bb_mysql_get_password)") \
        -h "$(bb_mysql_get_host)" \
        -P "$(bb_mysql_get_port)" \
        -u "$(bb_mysql_get_user)" \
        -e "SELECT VERSION();"
}


bb_mysql() {
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$(bb_mysql_get_password)") \
        -h "$(bb_mysql_get_host)" \
        -P "$(bb_mysql_get_port)" \
        -u "$(bb_mysql_get_user)" \
        -e "$1"
}

bb_mysql_raw() {
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$(bb_mysql_get_password)") \
        --batch \
        -N \
        --disable-column-names \
        -h "$(bb_mysql_get_host)" \
        -P "$(bb_mysql_get_port)" \
        -u "$(bb_mysql_get_user)" \
        -e "$1"
}

bb_mysql_csv() {
    bb_mysql_raw "$1" | awk -F'\t' '{ sep=""; for(i = 1; i <= NF; i++) { gsub(/\\t/,"\t",$i); gsub(/\\n/,"\n",$i); gsub(/\\\\/,"\\",$i); gsub(/"/,"\"\"",$i); printf sep"\""$i"\""; sep=","; if(i==NF){printf"\n"}}}'
}

# bb_mysql_check() {
#     if [[ -z "$BB_COMMON_LOADED" ]]; then
#         echo "common.sh must be loaded before databases.sh"
#         exit 1
#     fi

#     if ! binary_exists "mysql"; then
#         echo "Install mysql for mysql binary to be available"
#         exit 1
#     fi

#     if [[ -z "$(bb_mysql_get_host)" ]] || [[ -z "$DB_USER" ]] || [[ -z "$DB_PASSWORD" ]]; then
#         echo "Please configure host, user, password and port (optional). Either by redefining the proper bash functions (e.g.: bb_mysql_get_host()) or environment vars (e.g.: DB_HOST)"
#         exit 1
#     fi
# }