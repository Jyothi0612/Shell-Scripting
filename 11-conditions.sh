#!/bin/bash

user_id=$(id -u)

if [ $user_id -ne 0 ]; then
    echo "Please run this script with sudo access"
    exit 1
fi

echo "Proceeding..."

dnf install nginx -y

if [ $? -ne 0 ]; then
    echo "Nginx installation failed"
    exit 1
else
    echo "Nginx installed successfully"
fi 

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "MySQL installation failed"
    exit 1
else
    echo "MySQL installed successfully"
fi 