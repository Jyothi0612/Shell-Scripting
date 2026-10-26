#!/bin/bash
usage_threshold=20

disk_usage=$(df -hT | grep -v Filesystem)

while IFS= read -r line
do
    usage=$(echo $line | awk '{print $6}' | cut -d "%" -f1)
    partition=$(echo $line | awk '{print $7}')
    if [ "$usage" -ge  "$usage_threshold" ]; then
        message+="High disk usage on $partition: $usage \n"
    fi
done <<< "$disk_usage"

echo -e "$message"