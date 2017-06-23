#!/bin/bash
shopt -s expand_aliases
alias help='echo "Usage: st [dir]"'
if [[ "$1" == "--help" ]]; then help; exit; fi
################################################################################
###                                                                            #
### Script:   st [dir]                                                         #
###                                                                            #
### Purpose:  Check Git status, possibly outside working directory             #
###                                                                            #
### Args:     dir is a Git working directory                                   #
###                                                                            #
### Notes:    Useful to check many working directories                         #
###                                                                            #
### Requires: git                                                              #
###                                                                            #
### Returns:  Git status is shown on screen                                    #
###                                                                            #
################################################################################

if [[ -z $1 ]]; then dir=.; else dir=$1; fi

pushd "$dir" > /dev/null
git status
popd > /dev/null
