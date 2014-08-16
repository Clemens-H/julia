#!/bin/bash

# Usage: very similar to `install`
#   install.sh 755 src1 src2 ... dest

PERMS=$1
shift

LEN=$(($#-1))
ARGS=${@:1:$LEN}
DEST=${@:$#}

for SRC in ${ARGS[@]}; do
    # Copy file, then take output of the form 'src' -> 'dest' and get only 'dest'
    DESTFILE=$(cp -va $SRC $DEST | sed -e $'s/ -> /\\\n/g' | tail -n 1)

    # Now strip quotes if they exist
    DESTFILE="${DESTFILE%\"}"
    DESTFILE="${DESTFILE#\"}"

    chmod $PERMS $DESTFILE
done