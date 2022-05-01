#!/bin/bash

wid=$1
class=$2
instance=$3
consequences=$4


if [[ "${class,,}" == "steam" ]]; then
    if xprop -id "$wid" WM_NAME | grep -qs "Friends List"; then
	echo "state=floating"
    fi
fi

