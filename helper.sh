#!/bin/bash

preCommitHelper(){

	basedir=$1
	script=$2
	DATE=$(date +"%Y-%m-%d")

	#Checking existence of .git dir
	if [ -d .git ]; then

		cd .git/hooks

		#Checking pre-commit file exists
		if [ -f pre-commit ];
		then

			#Checking if it is a previous pre-commit hook defined by user
	    	#if ! grep -qs UNIQUE_VALUE pre-commit
	    	if [ ! -L pre-commit ];
			then
				#Backingup the old pre_commit hook
				mv pre-commit pre-commit-bkup-$DATE
				echo "Made a backup of existing pre-commit hook file"
			fi

		fi

		if [ "$(readlink pre-commit)" != "$basedir/pre-commit" ];
		then
			mv pre-commit pre-commit-bkup-$DATE
			#Symlinking pre-commit hook
			ln -s $basedir/pre-commit .
		fi

		#Checking pre-commit.d dir exist
		if [ ! -d pre-commit.d ]; then
			mkdir pre-commit.d
			chmod 775 pre-commit.d
			echo "pre-commit.d Created"

		fi

		cd pre-commit.d

		#Symlinking packageAsZip
		if [ "$(readlink $script)" != "$basedir/pre-commit.d/$script" ];
		then
			ln -s $basedir/pre-commit.d/$script .
			echo "Added a $script entry in .git/hooks/pre-commit.d"
		fi

		cd ..

		#Changing the permission
		chmod 775 pre-commit
		chmod 775 pre-commit.d/$script
		echo "changed the permission of .git/hooks/pre-commit"
	fi


}
removeHelper(){
	script=$1
	cd .git/hooks
	rm -f pre-commit.d/$script
	echo "Removed s$script"
}
