#!/bin/zsh

function debug {
#    echo "$*"
}

CONTEXTALIAS_ORIGINAL_ALIASES=`alias`
CONTEXTALIAS_CONFIG_NAME=".contextalias.zsh"
CONTEXTALIASS_CURRENT_CONFIG=""


debug "Current alias = $CONTEXTALIAS_ORIGINAL_ALIASES" 

function contextalias_chpwd_function {
    CA_S="${PWD}"
    debug "Starting chpwd function in $CA_S"
    localconfig=""
    while [ -n "${CA_S}" ]
    do
        if [ -e "$CA_S/$CONTEXTALIAS_CONFIG_NAME" ]; then
            localconfig="$CA_S/$CONTEXTALIAS_CONFIG_NAME"
            break
        fi
        CA_S=${CA_S%/*}
    done

    if [[ "x$localconfig" != "x$CONTEXTALIASS_CURRENT_CONFIG" ]]; then
        CONTEXTALIASS_CURRENT_CONFIG=$localconfig

        current_aliases=`alias`

        for a in ${(@f)current_aliases}; do
            aliascmd=${a%%=*}
            debug "Clearing current alias = '$aliascmd'"
            eval "builtin unalias -- '$aliascmd'"
        done

        for a in ${(@f)CONTEXTALIAS_ORIGINAL_ALIASES}; do
            aliascmd=${a%%=*}
            aliasval=${a#*=}
            debug "Setting alias command = '$aliascmd' value = '$aliasval'"
            eval "builtin alias -- '$aliascmd'=$aliasval"
        done

        if [[ "x$localconfig" != "x" ]]; then
            source $localconfig
        fi
    fi

    debug "Exiting chpwd function"
}

typeset -ga chpwd_functions
chpwd_functions+=contextalias_chpwd_function

