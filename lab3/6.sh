#!/bin/bash
SUM=0
COUNT=0
LAST_PPID="-1"
> 6_ans
while read LINE;
do	
	CUR_PPID=$(echo $LINE | cut -d " " -f 3 | sed -e "s/^Parent_ProcessID=//")
	CUR_AVG_SLEEP=$(echo $LINE | cut -d " " -f 5 | sed -e "s/^Average_Sleeping_Time=//")
	if [ "$LAST_PPID" -ne "$CUR_PPID" ]
	then
		if [ "$LAST_PPID" -ne "-1" ]
		then
			AVG=$(awk 'BEGIN{print ('"$SUM"'/'"$COUNT"')}')
			echo "Average_Sleeping_Children_of_ParentID=$LAST_PPID is $AVG" >> 6_ans
			echo >> 6_ans	
		fi
		SUM=$(awk 'BEGIN{print ('"$CUR_AVG_SLEEP"')}')
		COUNT=1
		LAST_PPID=$CUR_PPID
	else
		COUNT=$((COUNT+1))
		SUM=$(awk 'BEGIN{print ('"$SUM"'+'"$CUR_AVG_SLEEP"')}')
	fi
	echo "$LINE" >> 6_ans			
done < 5_ans
AVG=$(awk 'BEGIN{print ('"$SUM"'/'"$COUNT"')}')
echo "Average_Sleeping_Children_of_ParentID=$LAST_PPID is $AVG" >> 6_ans		
