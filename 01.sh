#!bin/bash

# WTF Bash functions can't return values.
# They are kinda useless ngl
do_partial_sums() {
    tmp=0 # Can't add spaces!!!!
    array=() # All variables are global rofl
    while read line
    do
        if [ -z "$line" ]
        then
            array+=($tmp)
            tmp=0
        else
            (( tmp += line))
        fi
    done < inputs/01.txt
    array+=($tmp)
}

comp_max() {
    max=0
    for val in "${array[@]}"
    do
        if [ $val -gt $max ]
        then
            max=$val
        fi
    done
}

do_partial_sums

# Part 1
comp_max
echo $max

# Part 2
IFS=$'\n' sorted=($(sort -n <<<"${array[*]}")) # Sort array of numbers
unset IFS
echo $((${sorted[-1]} + ${sorted[-2]} + ${sorted[-3]}))
