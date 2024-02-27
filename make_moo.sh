#!/bin/bash

#detect os family. Supports Deb and RPM

osFamily=$(uname -a|awk '{print $1}')
OS="none"
CowBin="none"

if [ "$osFamily" == "Darwin" ]; then
	if [ -f /usr/local/bin/brew ] ; then
		if [ ! -f /usr/local/bin/cowsay ]; then
			brew install cowsay
		fi;
		CowBin="/usr/local/bin/cowsay"
	else
		echo "HOMEBREW Required to install cowsay binary"
	fi;
elif [ "$osFamily" == "Linux" ]; then
	if [ -f /etc/os-release ]; then
		OS=$(cat /etc/os-release |grep ^NAME|awk '{print $1}'|sed -e 's/\(.*\)=\"//')
		#DEBIAN and CENTOS
	fi;
	
	# install cowsay
	if [ "$OS" == "Debian" ]; then
		sudo apt-get -y -q install cowsay
		CowBin="/usr/games/cowsay"
	elif [ "$OS" == "CentOS" ] || [ "$OS" == "RedHat" ]; then
		sudo yum -y -q install epel-release && yum -y -q install cowsay
		CowBin="/usr/bin/cowsay"
	fi;
fi;

COWSTRING="MOO MOO MOO MOO MOO"


clear
x=1
while [ $x -le 10 ]; 
do 
	${CowBin} ${COWSTRING}
	((x++))
done



