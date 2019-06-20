#!/bin/bash
shopt -s expand_aliases
alias help='echo "Usage: boot [-dfs] [script]"'
if [[ "$1" == "--help" ]]; then help; exit; fi
################################################################################
###                                                                            #
### Script:   boot [-d] [-f] [-s]                                              #
###                                                                            #
### Purpose:  Set up data files and software required for a TAF analysis       #
###                                                                            #
### Args:     d processes DATA.bib                                             #
###           f fast bootstrap with clean=FALSE                                #
###           s processes SOFTWARE.bib                                         #
###                                                                            #
### Requires: R, icesTAF                                                       #
###                                                                            #
### Returns:  Creates subdirectories inside bootstrap                          #
###                                                                            #
################################################################################

data=TRUE
force=FALSE
software=TRUE
while getopts "dfs" A; do
  case $A in
    d) software=FALSE;;
    f) force=TRUE;;
    s) data=FALSE;;
  esac
done
shift $((OPTIND-1))

args="data=$data, software=$software, force=$force"

Rscript --vanilla -e "icesTAF::taf.bootstrap($args)"
