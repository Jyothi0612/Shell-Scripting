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