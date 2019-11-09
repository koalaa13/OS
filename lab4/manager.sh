#!/bin/bash

help_message="Select a command:
list                       = list of processes in format \"PID : COMMAND\"
info <PID>                 = information about process with PID = <PID>
find <QUERY>               = list of processes which started with <QUERY> command
send <SIGNAL> <PID>        = send signal <SIGNAL> to a process <PID>
stream                     = turn on tracking mode, Ctrl+C to turn off
help                       = print help
exit                       = exit from manager"

function _get_comm {
	_res="-------"
	_comm=""
	_cmdline=""
	if [ -e "/proc/$1/cmdline" ];
	then
		_cmdline="$(tr -d '\0' </proc/$1/cmdline)"
	fi
	if [ -e "/proc/$1/comm" ];
	then
		_comm="$(tr -d '\0' </proc/$1/comm)"
	fi
	if [ -n "$_comm" ]
	then
		_res=$_comm
	fi
	if [ -n "$_cmdline" ]
	then
		_res=$_cmdline
	fi
	echo "$_res"
}

function _help {
	echo -e "\e[93m$help_message\e[0m"
}

function _make_short {
	echo "$(echo $1 | head -c50)"
}

function _list {
	echo -e "\e[1mProcesses\e[0m"
	for i in $(ls /proc | grep "^[0-9]*$" | sort -n)
	do
		echo -e "\e[32mPID = $i : CMDLINE = $(_make_short $(_get_comm $i))\e[0m"
	done
}

function _send {
	kill $1 $2
}

function _find {
	for i in $(ls /proc | grep "^[0-9]*$" | sort -n)
	do
		if [[ "$(_get_comm $i)" =~ "$1" ]]
		then
			echo -e "\e[34mPID = $i\e[0m"
		fi
	done
}

function _info {
	echo -e "\e[31mPID                = $1"
	ppid=$(cat 2>/dev/null "/proc/$1/status" | grep -hE "^PPid" | cut -d "	" -f 2)
	echo "PPID               = $ppid"
	echo "PPID_CMDLINK       = $(_make_short $(_get_comm $ppid))"
	echo "USER               = $(cat /proc/$1/uid_map | tr -s " " | cut -d " " -f2)"
	echo "PATH_TO_EXE	   = $(readlink /proc/$1/exe)"
	echo "PATH_TO_CWD	   = $(readlink /proc/$1/cwd)"
	echo -e "USED_MEMORY        = $(cat /proc/$1/statm | cut -d " " -f1)\e[0m"	
}

function _stream {
	trap 'echo ""; return' SIGINT
	pids=$(ls /proc | grep "^[0-9]*$" | sort -n)
	while true
	do
		cur_pids=$(ls /proc | grep "^[0-9]*$" | sort -n)
		for i in $cur_pids
		do
			if [[ " ${pids[*]} " != *"$i"* ]]
			then
				echo -e "\e[96mprocces $i ($(_make_short $(_get_comm $i))) started\e[0m"
			fi
		done
		for i in $pids
		do
			if [[ " ${cur_pids[*]} " != *"$i"* ]]
			then
				echo -e "\e[96mprocces $i finished\e[0m"
			fi
		done
		pids=$cur_pids
		sleep 2
	done 
}

_help

while true
do
	read in_comm
	comm=$(echo ${in_comm} | cut -d " " -f1)
	arg1=$(echo ${in_comm} | cut -d " " -f2)
	arg2=$(echo ${in_comm} | cut -d " " -f3)
	case $comm in
		'list' ) _list ;;
		'info' ) _info $arg1 ;;
		'find' ) _find $arg1 ;;
		'send' ) _send $arg1 $arg2 ;;
		'stream' ) _stream ;;
		'help' ) _help ;;
		'exit' ) exit 0 ;;
	esac
done
