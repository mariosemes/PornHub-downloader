#!/bin/bash

# DEPRECATED 9.11.2019.

FILE="phdler-new.sh"
URL="https://raw.githubusercontent.com/mariosemes/PornHub-downloader/master/phdler.sh"

wget $URL -O $HOME/.local/var/phdler/$FILE
echo $"Downloaded the new version"
mv $HOME/.local/var/phdler/$FILE $HOME/.local/bin/phdler
chmod +x $HOME/phdler/phdler.sh
echo $"New one installed."
echo $"------------------"
echo $"Update completed."
exit 1;