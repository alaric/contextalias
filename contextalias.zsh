#!/bin/zsh

function debug {
#    echo "$*"
}

CONTEXTALIAS_ORIGINAL_ALIASES=`alias`
CONTEXTALIAS_CONFIG_NAME=".contextalias.zsh"
CONTEXTALIASS_CURRENT_CONFIG=""


debug "Current alias = $CONTEXTALIAS_ORIGINAL_ALIASES" 

function contextalias_chpwd_function {
    S="${PWD}"
    debug "Starting chpwd function in $S"
    localconfig=""
    while [ -n "${S}" ]
    do
        if [ -e "$S/$CONTEXTALIAS_CONFIG_NAME" ]; then
            localconfig="$S/$CONTEXTALIAS_CONFIG_NAME"
            break
        fi
        S=${S%/*}
    done

    if [[ "x$localconfig" != "x$CONTEXTALIASS_CURRENT_CONFIG" ]]; then
        CONTEXTALIASS_CURRENT_CONFIG=$localconfig

        current_aliases=`alias`

        for a in ${(@f)current_aliases}; do
            aliasarr=(${(s:=:)a})
            aliascmd=${aliasarr[1]}
            debug "Clearing current alias = '$aliascmd'"
            builtin unalias $aliascmd
        done

        for a in ${(@f)CONTEXTALIAS_ORIGINAL_ALIASES}; do
            aliasarr=(${(s:=:)a})
            aliascmd=${aliasarr[1]}
            aliasval=${aliasarr[2]}
            debug "Setting alias command = '$aliascmd' value = '$aliasval'"
            eval "builtin alias $aliascmd=$aliasval"
        done

        if [[ "x$localconfig" != "x" ]]; then
            source $localconfig
        fi
    fi

    debug "Exiting chpwd function"
}

typeset -ga chpwd_functions
chpwd_functions+=contextalias_chpwd_function

