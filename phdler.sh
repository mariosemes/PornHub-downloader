#!/bin/bash

### Set default parameters
action=$1
command=$2
tag=$3

### Loading config file
source $HOME/phdler/phdler.config

### Start script

if [ "$action" == 'start' ]
	then	
		filename=$HOME/phdler/models.txt
		filelines=`cat $filename`
		echo Starting models
		for line in $filelines ; do
		       youtube-dl -w -v -i --playlist-start 1 --playlist-end $lastvideos --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$line'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$line'/videos/upload'
		done

		filenameps=$HOME/phdler/stars.txt
		filelinesps=`cat $filenameps`
		echo Starting stars
		for lineps in $filelinesps ; do
		        youtube-dl -w -v -i --playlist-start 1 --playlist-end $lastvideos --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineps'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$lineps'/videos/upload'
		done

		echo Script run `date "+%H:%M:%S   %d/%m/%y"` >> $HOME/phdler.log


elif [ "$action" == 'refresh' ]
	then
		filename=$HOME/phdler/models-new.txt
		filelines=`cat $filename`

		for line in $filelines ; do
		       echo Searching for $line
		       if grep -Fxq "$line" $HOME/phdler/models.txt
			       then
			       	echo "Model exists. Do you wish to download it anyways?"
					select yn in "yes" "no"; do
					    case $yn in
					        yes ) youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$line'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$line'/videos/upload'; break;;
					        no ) exit;;
					    esac
					done
			       else
			       	youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$line'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$line'/videos/upload'
			       	echo $line >> $HOME/phdler/models.txt
			       	echo $line added to models.txt
			   fi
		done

		filenameps=$HOME/phdler/stars-new.txt
		filelinesps=`cat $filenameps`

		for lineps in $filelinesps ; do
		        echo Searching for $lineps
		        if grep -Fxq "$lineps" $HOME/phdler/stars.txt
			       then
			       	echo "Pornstar exists. Do you wish to download it anyways?"
					select yn in "yes" "no"; do
					    case $yn in
					        yes ) youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineps'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$lineps'/videos/upload'; break;;
					        no ) exit;;
					    esac
					done
			       else
			       	youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineps'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$lineps'/videos/upload'
			       	echo $lineps >> $HOME/phdler/stars.txt
			       	echo $lineps added to stars.txt
			   fi
		done

elif [ "$action" == 'custom' ]
	then
		if [ "$command" == '' ]
		then
			clear
			echo $"-----------------"
			echo $"Please run [phdler custom <ph url>]"
			exit 1;
		else
		youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/handpicked/%(title)s.%(ext)s' $command
		fi

elif [ "$action" == 'add' ]
	then
		if [ "$command" == 'model' ]
			then
				if grep -Fxq "$tag" $HOME/phdler/models.txt
				then
					echo Model exists.
					exit 1;
				else
					echo $tag >> $HOME/phdler/models-new.txt
					echo $"Model added."
					exit 1;
				fi
		elif [ "$command" == 'pornstar' ]
			then
				if grep -Fxq "$tag" $HOME/phdler/stars.txt
				then
					echo Pornstar exists.
					exit 1;
				else
					echo $tag >> $HOME/phdler/stars-new.txt
					echo $"Pornstar added."
					exit 1;
				fi
		else
				clear
				echo $"-----------------"
				echo $"Please run [phdler add model/pornstar]"
				exit 1;
		fi

elif [ "$action" == 'clean' ]
	then
		if [ "$command" == 'models' ]
			then
				> $HOME/phdler/models-new.txt
				echo $"models-new.txt cleaned."
				exit 1;
				
		elif [ "$command" == 'pornstars' ]
			then
				> $HOME/phdler/stars-new.txt
				echo $"stars-new.txt cleaned."
				exit 1;
				
		else
				clear
				echo $"-----------------"
				echo $"Please run [phdler clean models/pornstars]"
				exit 1;
		fi

elif [ "$action" == 'remove' ]
	then
		if [ "$command" == 'model' ]
			then
				clear
				echo $"Listing of models:"
				echo $"-----------------"
				cat $HOME/phdler/models.txt
				echo $"-----------------"
				read -p 'Write the model name to remove (or type c to cancel): ' modelname

				if [ "$modelname" != 'c' ]
					then
						grep -v "$modelname" $HOME/phdler/models.txt > $HOME/phdler/models2.txt; mv $HOME/phdler/models2.txt $HOME/phdler/models.txt
						echo Deleted $modelname
						exit 1;
					else
						echo Canceling operation.
						exit 1;
				fi
				
		elif [ "$command" == 'pornstar' ]
			then
				clear
				echo $"Listing of pornstars:"
				echo $"-----------------"
				cat $HOME/phdler/stars.txt
				echo $"-----------------"
				read -p 'Write the pornstar name to remove (or type c to cancel): ' starname

				if [ "$starname" != 'c' ]
					then
						grep -v "$modelname" $HOME/phdler/stars.txt > $HOME/phdler/stars2.txt; mv $HOME/phdler/stars2.txt $HOME/phdler/stars.txt
						echo Deleted $starname
						exit 1;
					else
						echo Canceling operation.
						exit 1;
				fi
		else
			echo $"-----------------"
			echo $"Please run [phdler remove model/pornstar]"
			exit 1;
		fi

elif [ "$action" == 'config' ]
	then
		nano $HOME/phdler/phdler.config
		exit 1;

elif [ "$action" == 'update' ]
	then
		youtube-dl -U
		exit 1;

elif [ "$action" == '-h' ]
	then
		clear
		echo $"-----------------"
		echo $"You asked for help, here it comes! Run phdler with these commands:"
		echo $"-----------------"
		echo $"start (to start the script with already added models/pornstars)"
		echo $"refresh (to run the script and download from the fresh database)"
		echo $"custom *url* (to download a custom URL from PornHub)"
		echo $"add *model or pornstar* (to add a new model or pornstar to the database)"
		echo $"remove *model or pornstar* (to remove a model or pornstar from the database)"
		echo $"clean *models or pornstars* (to clean the -new.txt database)"
		echo $"config (to edit the config file)"
		echo $"update (to update youtube-dl to the latest version. Root permissions maybe needed)"
		echo $"-----------------"
		echo $"Example: phdler add model here-goes-the-model-name"
		echo $"-----------------"
		exit 1;

else
		clear
		echo $"-----------------"
		echo $"Please run phdler with these commands:"
		echo $"[start | refresh | custom | add | remove | clean | update | config | -h for help]"
		echo $"-----------------"
		exit 1;
fi
