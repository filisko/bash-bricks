#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "$DIR/../boot.sh"
source "$BB_LIB_DIR/env.sh"
source "$BB_LIB_DIR/mysql.sh"

load_env "$DIR/.env"

echo $TEST

# # get results and foreach them
# result=$(bb_mysql_raw "SELECT id,title,description FROM my_database.articles LIMIT 5")
# OLDIFS=$IFS
# IFS=$'\t'
# echo "$result" | while read id title description
# do
#     echo "$id $title $description"
# done
# IFS=$OLDIFS


# # get results and convert them to csv
# csv_result=$(bb_mysql_csv "SELECT ref,title,location FROM announcements.announcement LIMIT 5")

