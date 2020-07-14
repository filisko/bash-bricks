#!/usr/bin/env bash

# get results and foreach them
result=$(bb_mysql_raw "SELECT id,title,description FROM my_database.articles LIMIT 5")
OLDIFS=$IFS
IFS=$'\t'
echo "$result" | while read id title description
do
    echo "$id $title $description"
done
IFS=$OLDIFS


# get results and convert them to csv
csv_result=$(bb_mysql_csv "SELECT ref,title,location FROM announcements.announcement LIMIT 5")

