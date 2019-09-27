# PornHub Downloader

[![GitHub Issues Open](https://github-basic-badges.herokuapp.com/issues/mariosemes/PornHub-downloader.svg)]()


Hello everyone. This project was created for myself as a platform for learning bash. Hope its gonna help someone out :)

**(This script runs and its tested on Ubuntu 16.04 & 18.04)**

## Requirements
This script does not run without this tools:
1. YouTube-DL (sudo apt-get install youtube-dl)
2. aria2c (sudo apt-get install aria2)

## Installation
1. Download the script
2. Apply permission to execute:
```bash
$ chmod +x /path/to/phdler.sh
```
3. **(Recommended)** If you want to use the script globally, you need to copy the file to your /usr/local/bin directory. For easier use, create a symlink without the .sh extension like this:
```bash
$ sudo ln -s /path/to/phdler.sh /usr/local/bin/phdler
```

## Before usage !!!
Before you run the script for the first time, please go to your downloaded location of phdler and edit the PATH locations in phdler.sh. Use any editor you like (nano, vim, etc.)

**phdler folder is where you downloaded the script**
```bash
filelocation=/path/to/phdler/
```
**dllocation is where you want phdler to download media**
```bash
dllocation=/path/to/your/download/folder
```
**updated.txt is where you want the updated.txt file to be placed**
```bash
updatefile=/path/to/your/updated.txt
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
$ phdler [start | refresh | custom | add] [url | model | pornstar] [url]
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
