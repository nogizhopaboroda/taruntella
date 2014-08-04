#!/bin/bash

# ------------------------------------------------------------------------------
# Defaults:
# ------------------------------------------------------------------------------

if [ -f $PWD/Ttasks ];
then
   source $PWD/Ttasks #taskfile
fi

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

function aaa(){
	# save current directory then cd to "$1"
	  pushd "$1" >/dev/null
	  # for each non-hidden (i.e. not starting with .) file/directory...
	  for file in * ; do
	    # print file/direcotry name if it really exists...
	    test -e "$file" && echo "$2$file"
	    # if directory, go down and list directory contents too
	    test -d "$file" && my_ls "$file" "$2  "
	  done
	  # restore directory
	  popd >/dev/null
}

last=""
function __pipe() {
	params_string="${@}"
	params="${params_string#*[ ]}"
	if [ "$2" == "" ]; then
		echo $last_state
		return 0
	fi
	
	last_state=$($2 ${last_state})
	__pipe $params
}


function __uninstall() {
	sed '/alias taruntella=/d' ~/.zshrc > ~/.tempshrc
	mv ~/.tempshrc ~/.zshrc 
	rm -rf ~/.taruntella
}

# ------------------------------------------------------------------------------
# Parsing command line parameters
# ------------------------------------------------------------------------------

shopt -s extglob
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
		"pipe")
			__pipe $@
			exit 0
			;;	
		http?(s)://*)
			__remote $1 $2
			exit 0
			;;	
		"uninstall")
			__uninstall
			exit 0
			;;	
		*) 
			#__task_exists $1 && $1 $2 || __no_such_task $1
			$1 $@
			exit 1
			;;
	esac
	
done


# ------------------------------------------------------------------------------
# Default action:
# ------------------------------------------------------------------------------

__help