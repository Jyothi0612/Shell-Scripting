#!/bin/bash

user_id=$(id -u)
logs_folder="/var/log/shell-practice"
logs_file="${logs_folder}/${0}.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $user_id -ne 0 ]; then
    echo "Please run this script with sudo access"
    exit 1
fi

mkdir -p $logs_folder

echo "Script started execution at $(date +"%F %T")" &>> $logs_file

validate() {
    if [ $1 != 0 ]; then
        echo -e "${2}..${R}Failed${N}" | tee -a $logs_file
        exit 1
    else
        echo -e "${2}..${G}Success${N}" | tee -a $logs_file
    fi 
}

for package in $@
do
    dnf list installed ${package} &>> $logs_file
    if [ $? -eq 0 ]; then
        echo -e "${package} is already installed...${Y}Skipping${N}"
    else
        echo "Going to install ${package}..."
        dnf install ${package} -y &>> $logs_file
        validate $? "${package} installation"
    fi
done