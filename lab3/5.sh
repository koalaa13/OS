#!/bin/bash
PIDS=$(ps aux | sed 1d | tr -s " " | cut -d " " -f 2)
> 5_ans
for pid in $PIDS
do
	PPid=$(cat 2>/dev/null "/proc/${pid}/status" | grep -hE "^PPid" | cut -d "	" -f 2)
	if [ -n "$PPid" ]
	then
		sum_exec_runtime=$(cat 2>/dev/null "/proc/${pid}/sched" | grep -hE "^se.sum_exec_runtime" | tr -s " " | cut -d " " -f 3)
		switches=$(cat 2>/dev/null "/proc/${pid}/sched" | grep -hE "^nr_switches" | tr -s " " | cut -d " " -f 3)
		avg_atom=$((-1))
		if [ "$avg_atom" -ne 0 ]
		then
			avg_atom=$(awk 'BEGIN{print ('"$sum_exec_runtime"'/'"$switches"')}')
		fi
		echo "ProcessID=$pid : Parent_ProcessID=$PPid : Average_Sleeping_Time=$avg_atom" >> 5_ans 
	fi
done
sort -k3 -t "=" -h -o 5_ans 5_ans

