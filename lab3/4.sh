#!/bin/bash
PIDS=$(ps aux | sed 1d | tr -s " " | cut -d " " -f 2)
tmp=""
for pid in $PIDS
do
	RESIDENT=$(cat 2>/dev/null "/proc/${pid}/statm" | cut -d " " -f 2)
	SHARE=$(cat 2>/dev/null "/proc/${pid}/statm" | cut -d " " -f 3)
	if [ -n "$RESIDENT" ] && [ -n "$SHARE" ];
	then
		DIV=$((RESIDENT-SHARE))
		tmp="$tmp$pid:$DIV "
	fi
done
echo $tmp | tr " " "\n" | sort -t ":" -k 2 -nr > 4_ans
