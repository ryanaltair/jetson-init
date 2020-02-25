#!/bin/bash

function retry()
{
    local n=0
    local try=$1
    local cmd="${@: 2}"

    [[ $# -le 1 ]] && {
    echo "Usage $0 <retry_number> <Command>"; }

    until [[ $n -ge $try ]]
    do
        $cmd && break || {
            ((n++))
            echo "Retry $n: $cmd"
            }
    done

    if [[ $n -ge $try ]]
    then
        echo "Run failed: $cmd"
        return 1
    fi
}

retry $@
