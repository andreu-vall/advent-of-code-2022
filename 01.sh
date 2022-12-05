#!bin/bash

# A hell lot of $'s

# WTF Bash functions can't return values!
# We need to echo the values and capture them in a variable
do_partial_sums() {
    tmp=0 # Can't add spaces!!!!
    array_tmp=() # All variables are global, watch out
    while read line
    do
        if [ -z "$line" ]
        then
            array_tmp+=($tmp)
            tmp=0
        else
            (( tmp += line))
        fi
    done < inputs/01.txt
    array_tmp+=($tmp)
    echo ${array_tmp[@]}
}

comp_max() {
    max=0
    for val in $@ # All the arguments (the array is split)
    do
        if [ $val -gt $max ]
        then
            max=$val
        fi
    done
    echo $max
}

array=($(do_partial_sums))

# Part 1
echo $(comp_max "${array[@]}")

# Part 2
IFS=$'\n' sorted=($(sort -n <<<"${array[*]}")) # Sort array of numbers
unset IFS
echo $((${sorted[-1]} + ${sorted[-2]} + ${sorted[-3]}))
