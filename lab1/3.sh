#!/bin/bash
res=""
cur=""
while true
do
	read cur
	if [[ "$cur" = "q" ]]
	then 
		break
	fi
	res+=$cur
done
echo $res
