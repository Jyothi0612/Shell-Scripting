#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

source_dir=$1
destination_dir=$2
days=${3:-14}

usage(){
    echo -e "${R}USAGE:: $0 [SOURCE_DIR] $1 [DESTINATION_DIR]${N}"
    exit 1
}

if [ -z "$source_dir" ] || [ -z "$destination_dir" ]; then
    echo -e "${R}ERROR:: Missing parameters${N}"
    usage
fi

if [ ! -d "$source_dir" ]; then
    echo -e "${R}ERROR: $source_dir doesn't exist${N}"
fi

if [ ! -d "$destination_dir"]; then
    echo "${R}ERROR: $destination_dir doesn't exist${N}"
fi

echo "Scanning files older than $days in $source_dir"
files_to_compress=$(find $source_dir -name "*.log" -type f -mtime +$days)

if [ -z "$files_to_compress" ]; then
    echo "No log files found older than $days"
    exit 0
fi

while IFS= read -r line
do
    echo $line
done <<< "$files_to_compress"

