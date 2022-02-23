#!/bin/bash

# DEPRECATED 9.11.2019.

version="1.0.7"

### Set default parameters
action=$1
command=$2

var=$HOME/.local/var/phdler

stars_file="$var/stars.txt"
stars_file_new="$var/stars-new.txt"
models_file="$var/models.txt"
models_file_new="$var/models-new.txt"
channels_file="$var/channels.txt"
channels_file_new="$var/channels-new.txt"
users_file="$var/users.txt"
users_file_new="$var/users-new.txt"

### Loading config file
source $HOME/.config/phdler.config

### Start script

if [ "$action" == 'start' ]
	then	
		echo Starting models
		while IFS= read -r modellist; do
			youtube-dl $ytdlsetts $lastvideos -o $dllocation'/'$modellist'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$modellist'/videos/upload'
		done <$models_file

		echo Starting stars
		while IFS= read -r starslist; do
			youtube-dl $ytdlsetts $lastvideos -o $dllocation'/'$starslist'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$starslist'/videos/upload'
		done <$stars_file

		echo Starting users
		while IFS= read -r userlist; do
			youtube-dl $ytdlsetts $lastvideos -o $dllocation'/'$userlist'/%(title)s.%(ext)s' 'https://www.pornhub.com/users/'$userlist'/videos/public'
		done <$users_file

		echo Starting channels
		while IFS= read -r channellist; do
			youtube-dl $ytdlsetts $lastvideos -o $dllocation'/'$channellist'/%(title)s.%(ext)s' 'https://www.pornhub.com/channels/'$channellist'/videos'
		done <$channels_file

		echo Script run `date "+%H:%M:%S   %d/%m/%y"` >> $var.log


elif [ "$action" == 'refresh' ]
	then
		while read model; do
			echo Searching for $model
			youtube-dl $ytdlsetts -o $dllocation'/'$model'/%(title)s.%(ext)s' 'https://www.pornhub.com/model/'$model'/videos/upload'

			if grep -Fxq "$model" $models_file
			then
				echo "Model exists. Not adding to models.txt"
			else
				echo $model >> $models_file
				echo $model added to models.txt
			fi
		done <$models_file_new

		while read star; do
			echo Searching for $star
			youtube-dl $ytdlsetts -o $dllocation'/'$star'/%(title)s.%(ext)s' 'https://www.pornhub.com/pornstar/'$star'/videos/upload'

			if grep -Fxq "$star" $stars_file
			then
				echo "Pornstar exists. Not adding to stars.txt"
			else
				echo $star >> $stars_file
				echo $star added to stars.txt
			fi
		done <$stars_file_new

		while read user; do
			echo Searching for $user
			youtube-dl $ytdlsetts -o $dllocation'/'$user'/%(title)s.%(ext)s' 'https://www.pornhub.com/users/'$user'/videos/public'

			if grep -Fxq "$user" $users_file
			then
				echo "User exists. Not adding to users.txt"
			else
				echo $user >> $users_file
				echo $user added to users.txt
			fi
		done <$users_file_new

		while read channel; do
			echo Searching for $channel
			youtube-dl $ytdlsetts -o $dllocation'/'$channel'/%(title)s.%(ext)s' 'https://www.pornhub.com/channels/'$channel'/videos'

			if grep -Fxq "$channel" $channels_file
			then
				echo "Channel exists. Not adding to channels.txt"
			else
				echo $channel >> $channels_file
				echo $channel added to channels.txt
			fi
		done <$channels_file_new

elif [ "$action" == 'custom' ]
		then
			if [ "$command" == '' ]
			then
				clear
				echo "-----------------"
				echo "Please run [phdler custom <ph url>]"
				echo "-----------------"
				exit 1;
			else
				youtube-dl $ytdlsetts -o $dllocation'/handpicked/%(title)s.%(ext)s' $command
			fi

elif [ "$action" == 'add' ]
		then
			if [ "$command" == '' ]
			then
				clear
				echo "-----------------"
				echo "Please run [phdler add model-name/pornstar-name/user-name/channel-name]"
				echo "-----------------"
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
						echo "Pornstar added."
						echo "---------------"
						echo "Please run [phdler refresh] to download new content."
						echo "-----------------"
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
						echo "Model added."
						echo "---------------"
						echo "Please run [phdler refresh] to download new content."
						echo "-----------------"
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
						echo "Channel added."
						echo "---------------"
						echo "Please run [phdler refresh] to download new content."
						echo "-----------------"
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
						echo "User added."
						echo "-----------------"
						echo "Please run [phdler refresh] to download new content."
						echo "-----------------"
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
				echo "models-new.txt cleaned."
				exit 1;

			elif [ "$command" == 'pornstars' ]
				then
					> $stars_file_new
					echo "stars-new.txt cleaned."
					exit 1;

			elif [ "$command" == 'channels' ]
				then
					> $channels_file_new
					echo "channels-new.txt cleaned."
					exit 1;

			elif [ "$command" == 'users' ]
				then
					> $users_file_new
					echo "users-new.txt cleaned."
					exit 1;

			elif [ "$command" == 'all' ]
				then
					> $models_file_new
					> $stars_file_new
					> $channels_file_new
					> $users_file_new
					echo "All fresh txts are cleaned."
					exit 1;

				else
					clear
					echo "-----------------"
					echo "Please run phdler clean with these commands:"
					echo "[models | pornstars | channels | users | all]"
					echo "-----------------"
					exit 1;
				fi

elif [ "$action" == 'remove' ]
		then
			if [ "$command" == 'model' ]
			then
				clear
				echo "Listing of models:"
				echo "-----------------"
				while IFS= read -r modellist; do
					echo $modellist
				done <$models_file
				echo "-----------------"
				read -p 'Write the model name to remove (or type c to cancel): ' modelname

			if [ "$modelname" != 'c' ]
			then
				grep -v "$modelname" $models_file > $var/models2.txt; mv $var/models2.txt $models_file
				echo Deleted $modelname
				exit 1;
			else
				echo Canceling operation.
				exit 1;
			fi

			elif [ "$command" == 'pornstar' ]
				then
					clear
					echo "Listing of pornstars:"
					echo "-----------------"
					while IFS= read -r starslist; do
						echo $starslist
					done <$stars_file
					echo "-----------------"
					read -p 'Write the pornstar name to remove (or type c to cancel): ' starname

					if [ "$starname" != 'c' ]
					then
						grep -v "$modelname" $stars_file > $var/stars2.txt; mv $var/stars2.txt $stars_file
						echo Deleted $starname
						exit 1;
					else
						echo Canceling operation.
						exit 1;
					fi

			elif [ "$command" == 'channel' ]
				then
					clear
					echo "Listing of channels:"
					echo "-----------------"
					while IFS= read -r channellist; do
						echo $channellist
					done <$channels_file
					echo "-----------------"
					read -p 'Write the channel name to remove (or type c to cancel): ' channelname

					if [ "$channelname" != 'c' ]
					then
						grep -v "$channelname" $channels_file > $var/channels2.txt; mv $var/channels2.txt $channels_file
						echo Deleted $channelname
						exit 1;
					else
						echo Canceling operation.
						exit 1;
					fi

			elif [ "$command" == 'user' ]
				then
					clear
					echo "Listing of users:"
					echo "-----------------"
					while IFS= read -r userlist; do
						echo $userlist
					done <$users_file
					echo "-----------------"
					read -p 'Write the user name to remove (or type c to cancel): ' usname

					if [ "$usname" != 'c' ]
					then
						grep -v "$usname" $users_file > $var/users2.txt; mv $var/users2.txt $users_file
						echo Deleted $usname
						exit 1;
					else
						echo Canceling operation.
						exit 1;
					fi

				else
					echo "-----------------"
					echo "Please run phdler remove with these commands:"
					echo "[model | pornstar | channel | user]"
					echo "-----------------"
					exit 1;
				fi

elif [ "$action" == 'list' ]
		then
			if [ "$command" == 'models' ]
			then
				clear
				echo "Listing of models:"
				echo "-----------------"
				while IFS= read -r modellist; do
					echo $modellist
				done <$models_file
				echo "-----------------"

			elif [ "$command" == 'pornstars' ]
				then
					clear
					echo "Listing of pornstars:"
					echo "-----------------"
					while IFS= read -r starslist; do
						echo $starslist
					done <$stars_file
					echo "-----------------"

			elif [ "$command" == 'channels' ]
				then
					clear
					echo "Listing of channels:"
					echo "-----------------"
					while IFS= read -r channellist; do
						echo $channellist
					done <$channels_file
					echo "-----------------"

			elif [ "$command" == 'users' ]
				then
					clear
					echo "Listing of users:"
					echo "-----------------"
					while IFS= read -r userlist; do
						echo $userlist
					done <$users_file
					echo "-----------------"

				else
					echo "-----------------"
					echo "Please run phdler list with these commands:"
					echo "[models | pornstars | channels | users]"
					echo "-----------------"
					exit 1;
			fi


elif [ "$action" == 'config' ]
		then
			nano $HOME/.config/phdler.config
			exit 1;

elif [ "$action" == 'update' ]
			then
				sh $var/update.sh
				exit 1;

elif [ "$action" == '-h' ]
				then
					clear
					echo "-----------------"
					echo "You asked for help, here it comes! Run phdler with these commands:"
					echo "-----------------"
					echo "start (start the script)"
					echo "refresh (run the script and download from the fresh database)"
					echo "custom *url* (download a custom URL from PornHub)"
					echo "add *model/pornstar/channel/user* (add to fresh database)"
					echo "list *models/pornstars/channels/users* (show your database)"
					echo "remove *model/pornstar/channel/user* (remove a model or pornstar from the database)"
					echo "clean *models/pornstars/channels/users* (clean the -new.txt database)"
					echo "config (edit the config file)"
					echo "update (update script to the latest version)"
					echo "-----------------"
					echo "Example: phdler add here-goes-the-model-name"
					echo "-----------------"
					exit 1;

elif [ "$action" == '-v' ]
		then
			echo "phdler version: $version"
			exit 1;

		else
			clear
			echo "-----------------"
			echo "Please run phdler with these commands:"
			echo "[start | refresh | custom | add | list | remove | clean | update | config | -h for help | -v for version]"
			echo "-----------------"
			exit 1;

fi
