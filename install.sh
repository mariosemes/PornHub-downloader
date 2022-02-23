#!/bin/bash

# DEPRECATED 9.11.2019.

### Checking if tools are installed
if ! [ -x "$(command -v youtube-dl)" ]; then
  echo $"Error: youtube-dl is not installed."
  echo $"Please, install the tool as mentioned in the installation guide."
  exit 1
fi

### Defining locations
bin=$HOME/.local/bin
var=$HOME/.local/var/phdler

### Moving files
mkdir -p $var
cp phdler.sh $bin/phdler
chmod +x $bin/phdler
cp phdler.config $HOME/.config
cp update.sh $bin/phdler-update
chmod +x $bin/phdler-update.sh
echo $"script & config moved"

if [ -f "$var/phdler/stars.txt" ]
	then
	    echo "stars.txt exists"
	else
	   	touch $var/stars.txt
	   	echo "stars.txt created"
fi

if [ -f "$var/stars-new.txt" ]
	then
	    echo "stars-new.txt exists"
	else
	   	touch $var/stars-new.txt
	   	echo "stars-new.txt created"
fi

if [ -f "$var/models.txt" ]
	then
	    echo "models.txt exists"
	else
	   	touch $var/models.txt
	   	echo "models.txt created"
fi

if [ -f "$var/models-new.txt" ]
	then
	    echo "models-new.txt exists"
	else
	   	touch $var/models-new.txt
	   	echo "models-new.txt created"
fi

if [ -f "$var/users.txt" ]
	then
	    echo "users.txt exists"
	else
	   	touch $var/users.txt
	   	echo "users.txt created"
fi

if [ -f "$var/users-new.txt" ]
	then
	    echo "users-new.txt exists"
	else
	   	touch $var/users-new.txt
	   	echo "users-new.txt created"
fi

if [ -f "$var/channels.txt" ]
	then
	    echo "channels.txt exists"
	else
	   	touch $var/channels.txt
	   	echo "channels.txt created"
fi

if [ -f "$var/channels-new.txt" ]
	then
	    echo "channels-new.txt exists"
	else
	   	touch $var/channels-new.txt
	   	echo "channels-new.txt created"
fi

echo "-----------------"
echo "Script installed."
echo "-----------------"
echo "To view usage type phdler -h"
echo "-----------------"