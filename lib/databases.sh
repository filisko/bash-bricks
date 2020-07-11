#!/usr/bin/env bash

bb_mysql() {
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$AUXMONEY_DB_PASSWORD") \
        -h "$AUXMONEY_DB_IP" \
        -u "$AUXMONEY_DB_USER" \
        -e "$1"
}

bb_mysql_raw() {
    mysql --defaults-extra-file=<(echo $'[client]\npassword='"$AUXMONEY_DB_PASSWORD") \
        --batch \
        -N \
        --disable-column-names \
        -h "$AUXMONEY_DB_IP" \
        -P "$AUXMONEY_DB_PORT" \
        -u "$AUXMONEY_DB_USER" \
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

