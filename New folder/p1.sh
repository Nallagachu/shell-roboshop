#!/bin/bash
read -p "Enter a number: " num

if [ "$num" -gt 10 ]; then
    echo "Number is greater than 10"
elif [ "$num" -eq 10 ]; then
    echo "Number is exactly 10"
else
    echo "Number is less than 10"
fi
