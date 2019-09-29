# PornHub Downloader

[![GitHub Issues Open](https://github-basic-badges.herokuapp.com/issues/mariosemes/PornHub-downloader.svg)]()

Hello everyone. This project was created for myself as a platform for learning bash. Hope its gonna help someone out :)

If you feel like it, you can donate me a beer or two ;) Just for the troubles!
[DONATE BUTTON](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=7MTJVTTQM9YQE&source=url)

**(This script runs and its tested on Ubuntu 16.04 & 18.04)**

## Requirements
This script does not run without this tools:
1. YouTube-DL (google it for installation)
2. aria2c (google it for installation)

## Installation
```bash
$ wget https://github.com/mariosemes/PornHub-downloader/archive/master.zip
$ unzip master.zip
$ cd PornHub-downloader-master/
$ chmod +x install.sh
$ ./install.sh

(Please run this command as admin and dont forget to rename .your-user-name.:)
$ sudo ln -s /home/your-user-name/phdler/phdler.sh /usr/local/bin/phdler

(Edit the config file with your download location path.)
$ phdler config
$ phdler
```

## How do I know the model/pornstar name or if its a model or a pornstar
**Pritty simple, lets take a look at this url:**

https://www.pornhub.com/model/themagicmuffin

1. **url:** https://www.pornhub.com/
2. **category:** model
3. **model name:** themagicmuffin

https://www.pornhub.com/pornstar/leolulu

1. **url:** https://www.pornhub.com/
2. **category:** pornstar
3. **pornstar name:** leolulu


## Usage
Basic command line syntax:
```bash
$ phdler [start | refresh | custom | add | remove | clean | update | config | -h for help] 
```

## Examples:
Start download
```bash
$ phdler start
```

Download a custom URL from PornHub
```bash
$ phdler custom https://url
```

Adding a new PornHub model to the database
```bash
$ phdler add model model-name-from-url
```

Adding a new PornHub pornstar to the database
```bash
$ phdler add pornstar model-name-from-url
```

Downloading new added models/pornstars
```bash
$ phdler refresh
```

## Warning
The default script "**phdler start**" uses the .txt files as a database and every time it runs, it will only download the latest 4 videos. So you dont spam PornHub and keep it calm :)
This is the reason why you have options like "**REFRESH**" to download and add the new models/pornstars to the database. 

## Best Practice
phdler is designed to run as a cronjob. Just type this:
`$ crontab -e`
and then on the end of the file add this:
`*/12 * * * phdler start >/dev/null 2>&1`
This will make the script run every 12 hours.

#### Permission problems or script not running with crontab
In case you are having permission problems, in crontab -e, just before the command add this line, and ofcourse, change **your-user-name** to your actuall user name.
PATH=/home/your-user-name/bin:/home/your-user-name/.local/bin:/home/your-user-name/.npm-packages/bin:/usr/local/sbin:/usr/local/bin:/$/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
