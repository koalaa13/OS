#!/bin/bash
echo -e "1)open nano\n2)open vi\n3)open links\n4)exit"
number=0
while true
do
	read number
	if [[ "$number" -lt 1 || "$number" -gt 4 ]]
	then
		echo "wrong input, try again"
	else
		break
	fi
done
case "$number" in
1)
	nano
	;;
2)
	vi
	;;
3)
	links
	;;
4)
	;;
esac
