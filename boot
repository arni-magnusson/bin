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
### Args:     d process only DATA.bib                                          #
###           f force bootstrap with force=TRUE                                #
###           s process only SOFTWARE.bib                                      #
###                                                                            #
### Requires: R, TAF                                                           #
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

args="software=$software, data=$data, force=$force"

Rscript --vanilla -e "TAF::taf.bootstrap($args)"
