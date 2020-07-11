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
# csv_result=$(bb_mysql_csv_n "SELECT ref,title,location FROM announcements.announcement LIMIT 5")
# OLDIFS=$IFS
# IFS=$'\t'
# echo "$csv_result" | while read ref title location
# do
#     echo "$ref $title $location"
# done
# IFS=$OLDIFS

# # csv_result=$(bb_mysql_csv_n "SELECT ref,title,location FROM announcements.announcement LIMIT 5" | awk -F'\t' '{ sep=""; for(i = 1; i <= NF; i++) { gsub(/\\t/,"\t",$i); gsub(/\\n/,"\n",$i); gsub(/\\\\/,"\\",$i); gsub(/"/,"\"\"",$i); printf sep"\""$i"\""; sep=","; if(i==NF){printf"\n"}}}')
# # csv_result=$(bb_mysql_csv_n "SELECT ref,title,location FROM announcements.announcement LIMIT 5")


bb_databases_check() {
    if [[ -z "$BB_COMMON_LOADED" ]]; then
        echo "common.sh must be loaded before databases.sh"
        exit 1
    fi

    if [[ "$DB_HOST" = "" ]] || [[ "$DB_USER" = "" ]] || [[ "$DB_PASSWORD" = "" ]]; then
        echo "Please configure DB_HOST, DB_USER, DB_PASSWORD and DB_PORT (this one optional) on your env file."
        exit 1
    fi

    if ! binary_exists "mysql"; then
        echo "Install mysql for mysql binary to be available"
        exit 1
    fi
}

bb_databases_check
BB_DATABASES_LOADED=1