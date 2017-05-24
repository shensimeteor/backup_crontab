#!/bin/bash

#$1: pwd, $2: $0 of this script
function mydir(){
    local is_begin_slash mydir
    is_begin_slash=$(echo $2 | grep "^/")
    if [ -n "$is_begin_slash" ]; then
        mydir=$(dirname $2)
    else
        mydir="$1"/$(dirname $2)
    fi
    echo $mydir
}

thisdir=$(mydir $(pwd) $0)
cd $thisdir
date=$(date +%Y%m%d)
crontab -l > crontab.temp

test -d saves || mkdir -p saves
ls saves/crontab.2* &>/dev/null
if [ $? -eq 0 ]; then
    cron_latest=$(ls saves/crontab.2* | tail -n 1)
    cron_diff=$(diff $cron_latest crontab.temp)
    if [ -n "$cron_diff" ]; then
        mv crontab.temp saves/crontab.$date
    fi
else
    mv crontab.temp saves/crontab.$date
fi
    

