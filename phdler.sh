#!/bin/bash

### Set default parameters
action=$1
command=$2
tag=$3

### Loading config file
source $HOME/phdler/phdler.config

### Start script
if [ "$action" == 'refresh' ]
	then
		filename="$filelocation"models-new.txt
		filelines=`cat $filename`

		for line in $filelines ; do
		       echo Searching for $line
		       if grep -Fxq "$line" "$filelocation"models.txt
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
			       	echo $line >> "$filelocation"models.txt
			       	echo $line added to models.txt
			   fi
		done

		filenameps="$filelocation"stars-new.txt
		filelinesps=`cat $filenameps`

		for lineps in $filelinesps ; do
		        echo Searching for $lineps
		        if grep -Fxq "$lineps" "$filelocation"stars.txt
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
			       	echo $lineps >> "$filelocation"stars.txt
			       	echo $lineps added to stars.txt
			   fi
		done

		echo updated >> $updatefile

elif [ "$action" == 'custom' ]
	then
		if [ "$command" == '' ]
		then
			echo $"Please run phdler custom <ph url>"
			exit 1;
		else
		youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/handpicked/%(title)s.%(ext)s' $command
		echo `date` >> $updatefile
		fi

elif [ "$action" == 'start' ]
	then 
		rm $updatefile		
		filename="$filelocation"models.txt
		filelines=`cat $filename`
		
		echo Starting models
		for line in $filelines ; do
		       echo Searching for $line - ${currentdate} >> $updatefile
		       youtube-dl -w -v -i --playlist-start 1 --playlist-end 4 --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$line'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$line'/videos/upload'
		done

		filenameps="$filelocation"stars.txt
		filelinesps=`cat $filenameps`
		echo Starting stars
		for lineps in $filelinesps ; do
		        echo Searching for $lineps - ${currentdate} >> $updatefile
		        youtube-dl -w -v -i --playlist-start 1 --playlist-end 4 --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineps'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$lineps'/videos/upload'
		done

elif [ "$action" == 'add' ]
	then
		if [ "$command" == 'model' ]
			then
				if grep -Fxq "$tag" "$filelocation"models.txt
				then
					echo Model exists.
					exit 1;
				else
					echo $tag >> "$filelocation"models-new.txt
					echo $"Model added."
					exit 1;
				fi
		elif [ "$command" == 'pornstar' ]
			then
				if grep -Fxq "$tag" "$filelocation"stars.txt
				then
					echo Pornstar exists.
					exit 1;
				else
					echo $tag >> "$filelocation"stars-new.txt
					echo $"Pornstar added."
					exit 1;
				fi
		else
				echo $"Please run phdler add model/pornstar"
				exit 1;
		fi

elif [ "$action" == 'update' ]
	then
		youtube-dl -U
		exit 1;

elif [ "$action" == '-h' ]
	then
		echo $"You asked for help, here it comes!"
		echo $"$ phdler start (to start the script with already added models/pornstars)"
		echo $"$ phdler refresh (to run the script and add/download the fresh database)"
		echo $"$ phdler custom *url* (to download a custom URL from PornHub)"
		echo $"$ phdler add *model or pornstar* (to add a new model or pornstar to the database)"
		echo $"$ phdler update (to update youtube-dl to the latest version. Root permissions maybe needed)"
		exit 1;

else
		echo $"Please run phdler with these commands: start, refresh, custom, add, update or -h for help!"
		exit 1;
fi
