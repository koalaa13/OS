#!/bin/bash
res=0
number=0
while true
do
	read number
	((res=res+1))
	if [[ "$number"\%2 -eq 0 ]]
	then
		break
	fi
done
echo $res
