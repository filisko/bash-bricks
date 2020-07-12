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
csv_result=$(bb_mysql_csv_n "SELECT ref,title,location FROM announcements.announcement LIMIT 5" | awk -F'\t' '{ sep=""; for(i = 1; i <= NF; i++) { gsub(/\\t/,"\t",$i); gsub(/\\n/,"\n",$i); gsub(/\\\\/,"\\",$i); gsub(/"/,"\"\"",$i); printf sep"\""$i"\""; sep=","; if(i==NF){printf"\n"}}}')
