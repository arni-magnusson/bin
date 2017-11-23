#!/bin/bash
shopt -s expand_aliases
################################################################################
###                                                                            #
### Script:   emacs [options] [file]                                           #
###                                                                            #
### Purpose:  Open newest Emacs, ignoring site file and site lisp              #
###                                                                            #
### Args:     See Emacs documentation                                          #
###                                                                            #
### Notes:    The window is maximized, unless user passed -fh or -Q            #
###           An ampersand is appended, if this is an X session and the user   #
###             did not pass -nw explicitly                                    #
###                                                                            #
### Requires: emacs                                                            #
###                                                                            #
### Returns:  Opens Emacs                                                      #
###                                                                            #
################################################################################

# 1  Look for newest Emacs executable
if [[ -d /opt/emacs/$EMACS_VERSION ]]; then
  emacs=/opt/emacs/$EMACS_VERSION/bin/emacs
else
  emacs=/usr/bin/emacs
fi

# 2  Examine whether user passed -fh, -nw or -Q
fh=0
nw=0
Q=0
for ARG in "$@"; do
  if [[ $ARG == "-fh" ]]; then fh=1; fi
  if [[ $ARG == "-nw" ]]; then nw=1; fi
  if [[ $ARG == "-Q" ]]; then Q=1; fi
done

# 3  Maximize window unless user passed -fh or -Q
if [[ $fh == 0 && $Q == 0 ]]; then mm="-mm"; else mm=""; fi

# 4  Run with ampersand if DISPLAY is defined and user did not pass -nw
if [[ -n $DISPLAY && $nw == 0 ]]; then
  $emacs --no-site-file --no-site-lisp $mm "$@" &
else
  $emacs --no-site-file --no-site-lisp $mm "$@"
fi
