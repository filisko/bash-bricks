#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "$DIR/../boot.sh"
source "$BB_LIB_DIR/env.sh"
source "$BB_LIB_DIR/mysql.sh"

load_env "$DIR/mariadb.env"

# you can configure either by env variables or functions
# function bb_mysql_get_host() {
#     echo "127.0.0.1"
# }

bb_mysql_check

# get results and foreach them
result=$(bb_mysql_raw "SELECT ID,user_login FROM wordpress.wp_users LIMIT 5")
OLDIFS=$IFS
IFS=$'\t'
echo "$result" | while read id username
do
    echo "$id $username"
done
IFS=$OLDIFS


# # get results and convert them to csv
# csv_result=$(bb_mysql_csv "SELECT ref,title,location FROM announcements.announcement LIMIT 5")

