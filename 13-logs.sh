#!/bin/bash

user_id=$(id -u)
logs_folder="/var/log/shell-practice"
logs_file="${logs_folder}/${0}.log"

if [ $user_id -ne 0 ]; then
    echo "Please run this script with sudo access"
    exit 1
fi

mkdir -p $logs_folder

echo "Script started execution at ${date + "%F %T"}"

validate() {
    if [ $1 != 0 ]; then
        echo "${2}..Failed" | tee -a $logs_file
        exit 1
    else
        echo "${2}..Success" | tee -a $logs_file
    fi 
}

echo "Proceeding..."
dnf install nginx -y &>> $logs_file
validate $? "Nginx installation"


dnf install mysql -y &>> $logs_file
validate $? "MySQL installation"

echo "Script execution completed at ${date + "%F %T")}"