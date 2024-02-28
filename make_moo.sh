#!/bin/bash

#detect os family. Supports Deb and RPM

function iterm () {
    local cmd=""
    local wd="$PWD"
    local args="$@"
    if [ -d "$1" ]; then
        wd="$1"
        args="${@:2}"
	#echo "DEBUG: args = ${args}"
    fi

    if [ -n "$args" ]; then
        # echo $args
        cmd="clear; $args"
	echo 
    fi
    osascript<<EOF
    set theCowCommand to "clear; ${cmd}"
    tell application "iTerm2"
        set newWindow to (create window with default profile)
        tell current session of newWindow
            write text theCowCommand
        end tell
    end tell
EOF
}

osFamily=$(uname -a|awk '{print $1}')
OS="none"
CowBin="none"
COWSTRING="MOO MOO MOO MOO MOO"

if [ "$osFamily" == "Darwin" ]; then
	if [ -f /usr/local/bin/brew ] ; then
		if [ ! -f /usr/local/bin/cowsay ]; then
			brew install cowsay
		fi;
		CowBin="/usr/local/bin/cowsay"
		CowCMD="${CowBin} ${COWSTRING}"
		# open multiple iTerms
		x=1
		while [ $x -le 10 ];
		do
		  iterm "${CowCMD}"
		  ((x++))
		done
	else
		echo "HOMEBREW Required to install cowsay binary"
	fi;
elif [ "$osFamily" == "Linux" ]; then
	if [ -f /etc/os-release ]; then
		OS=$(cat /etc/os-release |grep ^NAME|awk '{print $1}'|sed -e 's/\(.*\)=\"//')
		#DEBIAN and CENTOS
	fi;
	
	# install cowsay
	if [ "$OS" == "Debian" ]||[ "$OS" == "Kali" ]||[ "$OS" == "Ubuntu" ]; then
		sudo apt-get -y -q install cowsay
		CowBin="/usr/games/cowsay"
                CowCMD="${CowBin} ${COWSTRING}"
		a=1
		while [ $a -le 50 ];
		do
		  gnome-terminal -- bash -c "${CowCMD}; sleep 5; exit"
		  ((a++))
	  	done  
	elif [ "$OS" == "CentOS" ] || [ "$OS" == "RedHat" ]; then
		sudo yum -y -q install epel-release && yum -y -q install cowsay
		CowBin="/usr/bin/cowsay"
                CowCMD="${CowBin} ${COWSTRING}"
		b=1
		while [ $b -le 50 ];
		do
		  gnome-terminal -- bash -c "${CowCMD}; sleep 5; exit"
		  ((b++))
	  	done  
	fi;


fi;




