#!/bin/bash
SCRIPT_PATH=`dirname $0`
if [ "$1" == "--list" ];
then
    cat $SCRIPT_PATH/inventory.json
else
    echo ""
fi

