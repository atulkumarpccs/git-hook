#!/bin/bash


#Showing options if there is no argument passed
if [ $# -eq 0 ];then
	echo "bash git_hook.sh add_syntax => For adding the pre commit hook for syntax checking"
	echo "bash git_hook.sh add_packaging => For adding the pre commit hook for packaging"
    echo "bash git_hook.sh rm_all => For removing all pre commit hook"
    echo "bash git_hook.sh rm_syntax => For removing syntax pre commit hook"
    echo "bash git_hook.sh rm_packaging => For removing packaging pre commit hook"
    exit
fi

#Finding base path
pushd $(dirname "${0}") > /dev/null
basedir=$(pwd -L)

# Use "pwd -P" for the path without links. man bash for more info.
popd > /dev/null

#Syntax only pre-commit hook
if [ "$1" == "add_syntax" ];
then

	#Calling function
	source $basedir/helper.sh
	preCommitHelper $basedir syntaxCheck.sh
	exit
fi

#Packging pre-commit hook
if [ "$1" == "add_packaging" ];
then

	source $basedir/helper.sh
	preCommitHelper $basedir packageAsZip.php
	exit
fi

#Removing all pre-commit hooks
if [ "$1" == "rm_all" ];
then
	cd .git/hooks
	rm -f pre-commit
	echo "Removed pre-commit hook"
	rm -rf pre-commit.d
	echo "Removed pre-commit.d"
	exit
fi

#Removing syntax pre-commit hooks
if [ "$1" == "rm_syntax" ];
then
	#Calling function
	source $basedir/helper.sh
	removeHelper syntaxCheck.sh
	exit
fi

#Removing packaging pre-commit hooks
if [ "$1" == "rm_packaging" ];
then
	#Calling function
	source $basedir/helper.sh
	removeHelper packageAsZip.php
	exit
fi

