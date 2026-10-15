#!/bin/bash

var1=10
var2=20
var3=siva

echo "$var1 + $var2 + $var3 = $((var1 + var2 + var3))"

declare -i COUNT=5

COUNT=COUNT+1

ECHO "COUNT is $COUNT"

FRUITS=("Apple" "Banana" "Mango" "Grapes")
ECHO "Fruits are ${FRUITS[@]}"