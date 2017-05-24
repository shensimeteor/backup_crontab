#!/bin/bash
#read account_nodes, to ssh every account_node to run backup_crontab_onnode.sh
#MUST ensure: every account_nodes should have access (r/w) to current dir (script dir) and save_dir

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

$dir_save=$thisdir/saves/
for an in $(cat $this_dir/account_nodes); do
    test -d $this_dir/saves/$an || mkdir -p $this_dir/saves/$an
    ssh $an "$this_dir/backup_crontab_onnode.sh $dir_save/$an/"
done
