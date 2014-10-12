#!/bin/zsh

function debug {
    echo "$*"
}

CONTEXTALIAS_ORIGINAL_ALIASES=`alias`
CONTEXTALIAS_CONFIG_NAME=".contextalias.zsh"
debug "Current alias = $CONTEXTALIAS_ORIGINAL_ALIASES" 

function contextalias_chpwd_function {
    debug "Starting chpwd function"
    S="${PWD}"
    localconfig=""
    while [ -n "${S}" ]
    do
        if [[ -e "$S/$CONTEXTALIAS_CONFIG_NAME" ]]; then
            localconfig="$S/$CONTEXTALIAS_CONFIG_NAME"
            break
        fi
        S=${S%/*}
    done

    echo "$localconfig"

    debug "Exiting chpwd function"
}

typeset -ga chpwd_functions
chpwd_functions+=contextalias_chpwd_function

