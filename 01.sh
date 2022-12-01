#!bin/bash

max=0 # Can't add spaces
tmp=0
array=()
while read -r line
do
    if [ -z "$line" ]
    then
        array+=($tmp)
        tmp=0
    else
        (( tmp += line))
        if [ $tmp -gt $max ]
        then
            max=$tmp
        fi
    fi
done < inputs/input01.txt

# Part 1
echo $max

# Part 2
array+=($tmp)
IFS=$'\n' sorted=($(sort -n <<<"${array[*]}"));unset IFS # Sort array of numbers
echo $((${sorted[-1]} + ${sorted[-2]} + ${sorted[-3]}))
