#!/bin/bash
#
# enumivo_tn_bounce is used to restart a node that is acting badly or is down.
# usage: enumivo_tn_bounce.sh [arglist]
# arglist will be passed to the node's command line. First with no modifiers
# then with --hard-replay-blockchain and then a third time with --delete-all-blocks
#
# the data directory and log file are set by this script. Do not pass them on
# the command line.
#
# in most cases, simply running ./enumivo_tn_bounce.sh is sufficient.
#

pushd $ENUMIVO_HOME

if [ ! -f programs/enunode/enunode ]; then
    echo unable to locate binary for enunode
    exit 1
fi

config_base=etc/enumivo/node_
if [ -z "$ENUMIVO_NODE" ]; then
    DD=`ls -d ${config_base}[012]?`
    ddcount=`echo $DD | wc -w`
    if [ $ddcount -ne 1 ]; then
        echo $HOSTNAME has $ddcount config directories, bounce not possible. Set environment variable
        echo ENUMIVO_NODE to the 2-digit node id number to specify which node to bounce. For example:
        echo ENUMIVO_NODE=06 $0 \<options\>
        cd -
        exit 1
    fi
    OFS=$((${#DD}-2))
    export ENUMIVO_NODE=${DD:$OFS}
else
    DD=${config_base}$ENUMIVO_NODE
    if [ ! \( -d $DD \) ]; then
        echo no directory named $PWD/$DD
        cd -
        exit 1
    fi
fi

bash $ENUMIVO_HOME/scripts/enumivo_tn_down.sh
bash $ENUMIVO_HOME/scripts/enumivo_tn_up.sh "$*"
