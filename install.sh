#!/bin/bash

### Checking if tools are installed
if ! [ -x "$(command -v youtube-dl)" ]; then
  echo $"Error: youtube-dl is not installed."
  echo $"Please, install the tool as mentioned in the installation guide."
  ecto $"or try to install it: sudo apt-get install youtube-dl -y"
fi

if ! [ -x "$(command -v aria2c)" ]; then
  echo $"Error: aria2c is not installed."
  echo $"Please, install the tool as mentioned in the installation guide."
  ecto $"or try to install it: sudo apt-get install aria2 -y"
fi

### Moving files
mkdir $HOME/phdler
echo $"phdler folder created"
cp phdler.sh $HOME/phdler/phdler.sh
chmod +x $HOME/phdler/phdler.sh
cp phdler.config $HOME/phdler/phdler.config
cp phdler.sh $HOME/phdler/update.sh
chmod +x $HOME/phdler/update.sh
echo $"script & config moved"
touch $HOME/phdler/stars.txt
touch $HOME/phdler/stars-new.txt
touch $HOME/phdler/models.txt
touch $HOME/phdler/models-new.txt
echo $"files created"
echo $"-----------------"
echo $"Script installed."
echo $"-----------------"
echo $"Please run this command as admin and dont forget to rename .your-user-name.:"
echo $"sudo ln -s /home/your-user-name/phdler/phdler.sh /usr/local/bin/phdler"
echo $"-----------------"
exit 1;
