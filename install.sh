#!/bin/bash

### Checking if tools are installed
if ! [ -x "$(command -v youtube-dl)" ]; then
  echo $"Error: youtube-dl is not installed."
  echo $"Please, install the tool as mentioned in the installation guide."
fi

if ! [ -x "$(command -v aria2c)" ]; then
  echo $"Error: aria2c is not installed."
  echo $"Please, install the tool as mentioned in the installation guide."
  exit 1;
fi 

### Moving files
mkdir $HOME/phdler
echo $"phdler folder created"
cp phdler.sh $HOME/phdler/phdler.sh
chmod +x $HOME/phdler/phdler.sh
cp phdler.config $HOME/phdler/phdler.config
cp update.sh $HOME/phdler/update.sh
chmod +x $HOME/phdler/update.sh
echo $"script & config moved"

if [ -f "$HOME/phdler/stars.txt" ]
	then
	    echo "stars.txt exists"
	else
	   	touch $HOME/phdler/stars.txt
	   	echo "stars.txt created"
fi

if [ -f "$HOME/phdler/stars-new.txt" ]
	then
	    echo "stars-new.txt exists"
	else
	   	touch $HOME/phdler/stars-new.txt
	   	echo "stars-new.txt created"
fi

if [ -f "$HOME/phdler/models.txt" ]
	then
	    echo "models.txt exists"
	else
	   	touch $HOME/phdler/models.txt
	   	echo "models.txt created"
fi

if [ -f "$HOME/phdler/models-new.txt" ]
	then
	    echo "models-new.txt exists"
	else
	   	touch $HOME/phdler/models-new.txt
	   	echo "models-new.txt created"
fi

if [ -f "$HOME/phdler/users.txt" ]
	then
	    echo "users.txt exists"
	else
	   	touch $HOME/phdler/users.txt
	   	echo "users.txt created"
fi

if [ -f "$HOME/phdler/users-new.txt" ]
	then
	    echo "users-new.txt exists"
	else
	   	touch $HOME/phdler/users-new.txt
	   	echo "users-new.txt created"
fi

if [ -f "$HOME/phdler/channels.txt" ]
	then
	    echo "channels.txt exists"
	else
	   	touch $HOME/phdler/channels.txt
	   	echo "channels.txt created"
fi

if [ -f "$HOME/phdler/channels-new.txt" ]
	then
	    echo "channels-new.txt exists"
	else
	   	touch $HOME/phdler/channels-new.txt
	   	echo "channels-new.txt created"
fi

echo "-----------------"
echo "Script installed."
echo "-----------------"
echo "Please run this command as admin:"
echo "sudo ln -s ~/phdler/phdler.sh /usr/local/bin/phdler"
echo "-----------------"
exit 1;
