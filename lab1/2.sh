#!/bin/bash
reg='^[+-]?[0-9]+([.][0-9]+)?$'
if [ $# -ne 3 ]
then
	echo "Wrong count of arguments"
	exit 1
fi

if ! [[ $1 =~ $reg ]] 
then
	echo "Error: first argument is not a number"
	exit 1
fi


if ! [[ $2 =~ $reg ]] 
then
	echo "Error: second argument is not a number"
	exit 1
fi


if ! [[ $3 =~ $reg ]] 
then
	echo "Error: third argument is not a number"
	exit 1
fi

res=$1
if [ "$res" -lt "$2" ]
then
	res="$2"
fi

if [ "$res" -lt "$3" ]
then
	res="$3"
fi

echo $res

