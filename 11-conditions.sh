#!/bin/bash

user_id=$(id -u)

if [ $user_id -ne 0 ]; then
    echo "Please run this script with sudo access"
    exit 1
fi

echo "Proceeding..."

dnf install nginxxx -y

if [ $? -ne 0 ]; then
    echo "Nginx installation failed"
    exit 1
else
    echo "Nginx installed successfully"
fi 