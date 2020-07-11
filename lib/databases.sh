#!/usr/bin/env bash

bb_mysql_check_env() {
    if [ "$DB_HOST" = "" ] || [ "$DB_PASSWORD" = "" ] || [ "$DB_USER" = "" ]; then
        return 1
    fi
}

bb_mysql() {
    if ! bb_mysql_check_env; then
        echo "Please configure DB_HOST, DB_USER, DB_PASSWORD and DB_PORT (this one optional) on your env file."
        return 1
    fi


    port=${DB_PORT:-3306}

    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$DB_PASSWORD") \
        -h "$DB_HOST" \
        -P "$port" \
        -u "$DB_USER" \
        -e "$1"
}

bb_mysql_raw() {
    if ! bb_mysql_check_env; then
        echo "Please configure DB_HOST, DB_USER, DB_PASSWORD and DB_PORT (this one optional) on your env file."
        return 1
    fi

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
