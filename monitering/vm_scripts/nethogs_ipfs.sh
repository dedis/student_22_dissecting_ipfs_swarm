command=`sudo nethogs -t -c 2 | grep ipfs | ts '[%Y-%m-%d %H:%M:%S]'`
echo $command
