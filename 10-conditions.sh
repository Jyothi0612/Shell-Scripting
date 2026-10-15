#!/bin/bash

echo "Please enter the marks"
read marks

if [ $marks -lt 33 ]; then
    echo "Fail"
elif [ $marks -ge 33 ] && [ $marks -lt 50 ]; then 
    echo "Third Class"
elif [ $marks -ge 50 ] && [ $marks -lt 60 ]; then
    echo "Second Class"
elif [ $marks -ge 60 ] && [ $marks -lt 75 ]; then
    echo "First Class"
else
    echo "Distinction"
fi