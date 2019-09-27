#!/bin/bash

### Set default parameters
action=$1
command=$2
tag=$3
filelocation=/home/msemes/phdler/
dllocation=/home/msemes/phmedia
currentdate=`date +"%d-%m-%Y %T"`
updatefile=/home/msemes/updated.txt

### Check if YouTube-DL has update
youtube-dl -U


### Start script
if [ "$action" == 'new' ]
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
			   echo "Do you wish to clean the models-new.txt file?"
				select yn in "yes" "no"; do
				    case $yn in
				        yes ) > "$filelocation"models.txt; break;;
				        no ) exit;;
				    esac
				done
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
				echo "Do you wish to clean the stars-new.txt file?"
				select yn in "yes" "no"; do
				    case $yn in
				        yes ) > "$filelocation"stars.txt; break;;
				        no ) exit;;
				    esac
				done
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

elif [ "$action" == 'run' ]
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
				echo $tag >> "$filelocation"models-new.txt
				echo $"Model added."
				exit 1;
		elif [ "$command" == 'pornstar' ]
			then
				echo $tag >> "$filelocation"stars-new.txt
				echo $"Pornstar added."
				exit 1;
		else
				echo $"Please run phdler add model/pornstar"
				exit 1;
		fi

else
		echo $"Please run phdler with these commands: run, new, custom or add"
		exit 1;
fi
