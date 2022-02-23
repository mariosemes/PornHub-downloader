#!/bin/bash

rm $HOME/.local/bin/phdler $HOME/.local/bin/phdler-update
rm -rf $HOME/.local/var/phdler

read -r -p "Do you want to delete the config file? [Y/n] " input

case $input in
      [yY][eE][sS]|[yY])
            rm $HOME/.config/phdler.config
            ;;
      [nN][oO]|[nN])
            echo "You got it, Come back soon"
            ;;
      *)
            echo "Invalid input..."
            exit 1
            ;;
esac
