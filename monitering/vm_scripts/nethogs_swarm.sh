command=`sudo nethogs -t -c 2 | grep bee | ts '[%Y-%m-%d %H:%M:%S]'`
echo $command
