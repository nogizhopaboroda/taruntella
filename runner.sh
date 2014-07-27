#!/bin/bash

# ------------------------------------------------------------------------------
# Defaults:
# ------------------------------------------------------------------------------

source $PWD/Ttasks #taskfile

# ------------------------------------------------------------------------------
# Private commands:
# ------------------------------------------------------------------------------

function __help {
	echo "Usage: $0 [OPTION]"
	echo 
	echo "Options:"
	echo "  <task_name>   - run task" 
	echo "  help    - prints this text"
	echo "  tasks   - print tasks" 
	echo "  remote   - run task from remote source" 
	echo 
	exit 1
}

function __task_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

function __no_such_task() {
	echo -e "\n\n$(tput setaf 1)task ${1} not found$(tput sgr0)\n\n"
	help
}

function __available_tasks() {
	echo "available tasks:"
	#refactor this
	declare -f -F | sed -n '/__.*/!p' | sed s/declare// | sed s/-f//
}

function __remote() {
	curl -s $1 > .temp_tasks
	source $PWD/.temp_tasks
	rm .temp_tasks
	$2
}


function __uninstall() {
	sed '/alias taruntella=/d' ~/.zshrc > ~/.tempshrc
	mv ~/.tempshrc ~/.zshrc 
	rm -rf ~/.taruntella
}

# ------------------------------------------------------------------------------
# Parsing command line parameters
# ------------------------------------------------------------------------------

while (( "$#" ))
do
	
	case "$1" in
		"help")
			__help
			exit 0
			;;
		"tasks")
			__available_tasks
			exit 0
			;;
		"remote")
			__remote $2 $3
			exit 0
			;;
		"uninstall")
			__uninstall
			exit 0
			;;	
		*) 
			__task_exists $1 && $1 $2 || __no_such_task $1
			exit 1
			;;
	esac
	
done


# ------------------------------------------------------------------------------
# Default action:
# ------------------------------------------------------------------------------

__help