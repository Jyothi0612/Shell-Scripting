#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

source_dir=$1
days=${2:-14}

usage(){
    echo -e "${R}USAGE:: $0 [SOURCE_DIR] [days(Optional, default to 14 days)]${N}"
    exit 1
}

if [ -z "$source_dir" ]; then
    echo -e "${R}ERROR:: Missing parameters${N}"
    usage
fi

if [ ! -d "$source_dir" ]; then
    echo -e "${R}ERROR: $source_dir doesn't exist${N}"
fi

echo "Scanning files older than $days in $source_dir"
files_to_delete=$(find $source_dir -name "*.log" -type f -mtime +$days)

if [ -z "$files_to_delete" ]; then
    echo "No log files found older than $days"
    exit 0
fi

while IFS= read -r line
do
    echo "File to be deleted: $line"
    rm -f $line
    echo "File deleted: $line"
done <<< "$files_to_delete"