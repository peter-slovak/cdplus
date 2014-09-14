#!/bin/bash

declare -a DIRS
regex='^[0-9]+$'

# YOUR CUSTOM PERSISTENT INDEXES
# DIRS[0]="/var/log/apache2"
# DIRS[1]="/home/user/Downloads"

# Testing functions
function function_exists {
    declare -f $1 &> /dev/null && echo "WARNING: function $1 was already declared in your environment!" 
}

function_exists test_number
function test_number {
    if ! [[ "$1" =~ $regex ]] ; then
        echo "ERROR: First argument must be a positive integer!"
        return 1
    fi
}

# Usage functions
function_exists add_usage
function add_usage {
    echo -e "Usage: add record_number \n\trecord_number\tIndex number this directory will be saved to\n" 
    return
}

function_exists list_usage
function list_usage {
    echo -e "Usage: list\n\tList all saved paths and their indexes\n" 
    return
}

function_exists flush_usage
function flush_usage {
    echo -e "Usage: flush\n\tClear all saved paths\n" 
    return
}

# Executive functions
function_exists add
function add {
    if [ "$#" -ne "1" ] ; then
        add_usage
    else
        test_number $1 && DIRS[$1]=`pwd`
    fi
}

function_exists list
function list {
    if [ "$#" -ne "0" ] ; then
        list_usage
    else
        for i in "${!DIRS[@]}"; do 
            printf "%s\t%s\n" "$i" "${DIRS[$i]}"
        done
    fi
}

function_exists flush
function flush {
    if [ "$#" -ne "0" ] ; then
        flush_usage
    else
        unset DIRS
        declare -a DIRS
        echo "Directory records flushed"
    fi
}

# Extend "cd" builtin
alias cd="cd_helper"
 
function cd_helper {
    # if cd-ing to home directory
    if [ "$#" -eq "0" ] ; then
        \cd
    # if directory is not a number, cd into it
    elif ! [[ "$1" =~ $regex ]] ; then
        \cd $1
    # if it is a number, but is a real directory, cd into it
    elif [ -d "$1" ] ; then
        \cd $1
    # else try to cd into indexed path
    elif [ ${DIRS[$1]+key_exists} ] ; then
        \cd ${DIRS[$1]}
    else
        echo "Index $1 does not exist"
    fi    
}
