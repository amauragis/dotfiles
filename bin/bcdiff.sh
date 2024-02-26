#!/bin/sh
exec 1>&-

/usr/bin/bcompare "$6" "$7" -title1="$3" -title2="$5" -leftreadonly &
sleep 1
#exit 0
