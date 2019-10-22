#!/bin/bash
#ps aux | sed 1d | tr -s " " | cut -d " " -f 2,11 | grep -hE "[[:digit:]]* /sbin/.*" | cut -d " " -f 1 > 3_ans
> 3_ans
PIDS=$(ps aux | sed 1d | tr -s " " | cut -d " " -f 2)
for CUR_PID in $PIDS
do
	CUR=$(readlink /proc/$CUR_PID/exe)
	if [[ $CUR =~ ^/bin/.* ]];
	then
		echo "$CUR_PID:$CUR" >> 3_ans
	fi
done
