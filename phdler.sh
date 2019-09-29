#!/bin/bash

### Set default parameters
action=$1
command=$2

stars_file="$HOME/phdler/stars.txt"
stars_file_new="$HOME/phdler/stars-new.txt"
models_file="$HOME/phdler/models.txt"
models_file_new="$HOME/phdler/models-new.txt"
channels_file="$HOME/phdler/channels.txt"
channels_file_new="$HOME/phdler/channels-new.txt"
users_file="$HOME/phdler/users.txt"
users_file_new="$HOME/phdler/users-new.txt"

### Loading config file
source $HOME/phdler/phdler.config

### Start script

if [ "$action" == 'start' ]
	then	
		filename=$models_file
		filelines=`cat $filename`
		echo Starting models
		for line in $filelines ; do
		       youtube-dl -w -v -i --playlist-start 1 --playlist-end $lastvideos --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$line'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$line'/videos/upload'
		done

		filenameps=$stars_file
		filelinesps=`cat $filenameps`
		echo Starting stars
		for lineps in $filelinesps ; do
		        youtube-dl -w -v -i --playlist-start 1 --playlist-end $lastvideos --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineps'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$lineps'/videos/upload'
		done

		filenameus=$users_file
		filelinesus=`cat $filenameus`
		echo Starting stars
		for lineus in $filelinesus ; do
		        youtube-dl -w -v -i --playlist-start 1 --playlist-end $lastvideos --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineus'/%(title)s.%(ext)s' 'https://www.pornhub.com/users/'$lineus'/videos/public'
		done

		filenamech=$channels_file
		filelinesch=`cat $filenamech`
		echo Starting stars
		for linech in $filelinesch ; do
		        youtube-dl -w -v -i --playlist-start 1 --playlist-end $lastvideos --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$linech'/%(title)s.%(ext)s' 'https://www.pornhub.com/channels/'$linech'/videos'
		done

		echo Script run `date "+%H:%M:%S   %d/%m/%y"` >> $HOME/phdler.log


elif [ "$action" == 'refresh' ]
	then
		filename=$models_file_new
		filelines=`cat $filename`

		for line in $filelines ; do
		       echo Searching for $line
		       if grep -Fxq "$line" $models_file
			       then
			       	echo "Model exists. Do you wish to download it anyways?"
					select yn in "yes" "no"; do
					    case $yn in
					        yes ) youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$line'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$line'/videos/upload'; break;;
					        no ) echo $"ok."
					    esac
					done
			       else
			       	youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$line'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$line'/videos/upload'
			       	echo $line >> $models_file
			       	echo $line added to models.txt
			   fi
		done

		filenameps=$stars_file_new
		filelinesps=`cat $filenameps`

		for lineps in $filelinesps ; do
		        echo Searching for $lineps
		        if grep -Fxq "$lineps" $stars_file
			       then
			       	echo "Pornstar exists. Do you wish to download it anyways?"
					select yn in "yes" "no"; do
					    case $yn in
					        yes ) youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineps'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$lineps'/videos/upload'; break;;
					        no ) echo $"ok."
					    esac
					done
			       else
			       	youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineps'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$lineps'/videos/upload'
			       	echo $lineps >> $stars_file
			       	echo $lineps added to stars.txt
			   fi
		done

		filenameus=$users_file_new
		filelinesus=`cat $filenameus`

		for lineus in $filelinesus ; do
		       echo Searching for $lineus
		       if grep -Fxq "$lineus" $users_file
			       then
			       	echo "User exists. Do you wish to download it anyways?"
					select yn in "yes" "no"; do
					    case $yn in
					        yes ) youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineus'/%(title)s.%(ext)s' 'https://www.pornhub.com/users/'$lineus'/videos/public'; break;;
					        no ) echo $"ok."
					    esac
					done
			       else
			       	youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$lineus'/%(title)s.%(ext)s' 'https://www.pornhub.com/users/'$lineus'/videos/public'
			       	echo $lineus >> $users_file
			       	echo $lineus added to users.txt
			   fi
		done

		filenamech=$channels_file_new
		filelinesch=`cat $filenamech`

		for linech in $filelinesch ; do
		       echo Searching for $linech
		       if grep -Fxq "$linech" $channels_file
			       then
			       	echo "Channel exists. Do you wish to download it anyways?"
					select yn in "yes" "no"; do
					    case $yn in
					        yes ) youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$linech'/%(title)s.%(ext)s' 'https://www.pornhub.com/channels/'$linech'/videos'; break;;
					        no ) echo $"ok."
					    esac
					done
			       else
			       	youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/'$linech'/%(title)s.%(ext)s' 'https://www.pornhub.com/channels/'$linech'/videos'
			       	echo $linech >> $channels_file
			       	echo $linech added to channels.txt
			   fi
		done

elif [ "$action" == 'custom' ]
	then
		if [ "$command" == '' ]
		then
			clear
			echo $"-----------------"
			echo $"Please run [phdler custom <ph url>]"
			echo $"-----------------"
			exit 1;
		else
		youtube-dl -w -v -i --external-downloader aria2c --external-downloader-args '--file-allocation=none -c -j 10 -x 16 --summary-interval=0' -o $dllocation'/handpicked/%(title)s.%(ext)s' $command
		fi

elif [ "$action" == 'add' ]
	then

		if [ "$command" == '' ]
		then
				clear
				echo $"-----------------"
				echo $"Please run [phdler add model-name/pornstar-name/user-name/channel-name]"
				echo $"-----------------"
				exit 1;
		else

		pornstarcheck=$(curl -s --head -w %{http_code} https://www.pornhub.com/pornstar/$command -o /dev/null)

		if [ "$pornstarcheck" == '200' ]
		then
			echo $command is a pornstar.
			if grep -Fxq "$command" $stars_file
			then
				echo Pornstar exists.
				exit 1;
			else
				echo $command >> $stars_file_new
				echo $"Pornstar added."
				echo $"---------------"
				echo $"Please run [phdler refresh] to download new content."
				echo $"-----------------"
				exit 1;
			fi
			exit 1;
		else
			echo $command is not a pornstar.
		fi

		modelcheck=$(curl -s --head -w %{http_code} https://www.pornhub.com/model/$command -o /dev/null)

		if [ "$modelcheck" == '200' ]
		then
			echo $command is a model.
			if grep -Fxq "$command" $models_file
			then
				echo Model exists.
				exit 1;
			else
				echo $command >> $models_file_new
				echo $"Model added."
				echo $"---------------"
				echo $"Please run [phdler refresh] to download new content."
				echo $"-----------------"
				exit 1;
			fi
			exit 1;
		else
			echo $command is not a model.
		fi

		channelcheck=$(curl -s --head -w %{http_code} https://www.pornhub.com/channels/$command -o /dev/null)

		if [ "$channelcheck" == '200' ]
		then
			echo $command is a channel.
			if grep -Fxq "$command" $channels_file
			then
				echo Channel exists.
				exit 1;
			else
				echo $command >> $channels_file_new
				echo $"Channel added."
				echo $"---------------"
				echo $"Please run [phdler refresh] to download new content."
				echo $"-----------------"
				exit 1;
			fi
			exit 1;
		else
			echo $command is not a channel.
		fi

		usercheck=$(curl -s --head -w %{http_code} https://www.pornhub.com/users/$command -o /dev/null)

		if [ "$usercheck" == '200' ]
		then
			echo $command is a user.
			if grep -Fxq "$command" $users_file
			then
				echo User exists.
				exit 1;
			else
				echo $command >> $users_file_new
				echo $"User added."
				echo $"-----------------"
				echo $"Please run [phdler refresh] to download new content."
				echo $"-----------------"
				exit 1;
			fi
			exit 1;
		else
			echo $command is not a user.
		fi
	fi

elif [ "$action" == 'clean' ]
	then
		if [ "$command" == 'models' ]
			then
				> $models_file_new
				echo $"models-new.txt cleaned."
				exit 1;
				
		elif [ "$command" == 'pornstars' ]
			then
				> $stars_file_new
				echo $"stars-new.txt cleaned."
				exit 1;

		elif [ "$command" == 'channels' ]
			then
				> $channels_file_new
				echo $"channels-new.txt cleaned."
				exit 1;

		elif [ "$command" == 'users' ]
			then
				> $users_file_new
				echo $"users-new.txt cleaned."
				exit 1;

		elif [ "$command" == 'all' ]
			then
				> $models_file_new
				> $stars_file_new
				> $channels_file_new
				> $users_file_new
				echo $"All fresh txts are cleaned."
				exit 1;
				
		else
				clear
				echo $"-----------------"
				echo $"Please run phdler clean with these commands:"
				echo $"[models | pornstars | channels | users | all]"
				echo $"-----------------"
				exit 1;
		fi

elif [ "$action" == 'remove' ]
	then
		if [ "$command" == 'model' ]
			then
				clear
				echo $"Listing of models:"
				echo $"-----------------"
				cat $models_file
				echo $"-----------------"
				read -p 'Write the model name to remove (or type c to cancel): ' modelname

				if [ "$modelname" != 'c' ]
					then
						grep -v "$modelname" $models_file > $HOME/phdler/models2.txt; mv $HOME/phdler/models2.txt $models_file
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
				cat $stars_file
				echo $"-----------------"
				read -p 'Write the pornstar name to remove (or type c to cancel): ' starname

				if [ "$starname" != 'c' ]
					then
						grep -v "$modelname" $stars_file > $HOME/phdler/stars2.txt; mv $HOME/phdler/stars2.txt $stars_file
						echo Deleted $starname
						exit 1;
					else
						echo Canceling operation.
						exit 1;
				fi

		elif [ "$command" == 'channel' ]
			then
				clear
				echo $"Listing of channels:"
				echo $"-----------------"
				cat $channels_file
				echo $"-----------------"
				read -p 'Write the channel name to remove (or type c to cancel): ' channelname

				if [ "$channelname" != 'c' ]
					then
						grep -v "$channelname" $channels_file > $HOME/phdler/channels2.txt; mv $HOME/phdler/channels2.txt $channels_file
						echo Deleted $channelname
						exit 1;
					else
						echo Canceling operation.
						exit 1;
				fi

		elif [ "$command" == 'user' ]
			then
				clear
				echo $"Listing of users:"
				echo $"-----------------"
				cat $users_file
				echo $"-----------------"
				read -p 'Write the user name to remove (or type c to cancel): ' usname

				if [ "$usname" != 'c' ]
					then
						grep -v "$usname" $users_file > $HOME/phdler/users2.txt; mv $HOME/phdler/users2.txt $users_file
						echo Deleted $usname
						exit 1;
					else
						echo Canceling operation.
						exit 1;
				fi

		else
			echo $"-----------------"
			echo $"Please run phdler remove with these commands:"
			echo $"[model | pornstar | channel | user]"
			echo $"-----------------"
			exit 1;
		fi

elif [ "$action" == 'config' ]
	then
		nano $HOME/phdler/phdler.config
		exit 1;

elif [ "$action" == 'update' ]
	then
		sh $HOME/phdler/update.sh
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
		echo $"add *model/pornstar/channel/user* (to add a new model or pornstar to the database)"
		echo $"remove *model/pornstar/channel/user* (to remove a model or pornstar from the database)"
		echo $"clean *models/pornstars/channels/users* (to clean the -new.txt database)"
		echo $"config (to edit the config file)"
		echo $"update (to update script to the latest version)"
		echo $"-----------------"
		echo $"Example: phdler add here-goes-the-model-name"
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
