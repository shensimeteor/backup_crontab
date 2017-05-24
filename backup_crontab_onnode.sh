#!/bin/bash
#save crontab to $1/crontab.<date> if it differs from the newest crontab.<date> file
narg=$#
if [ $narg -lt 1 ]; then
    echo "<usage> <dir to record backup crontabs>"
    exit 2
fi
dir=$1

cd $dir
date=$(date +%Y%m%d)
test -e crontab.temp && rm -rf crontab.temp
crontab -l > crontab.temp

ls crontab.2* &>/dev/null
if [ $? -eq 0 ]; then
    cron_latest=$(ls crontab.2* | tail -n 1)
    cron_diff=$(diff $cron_latest crontab.temp)
    if [ -n "$cron_diff" ]; then
        mv crontab.temp crontab.$date
    else
        rm -rf crontab.temp
    fi
else
    mv crontab.temp crontab.$date
fi
    

