export TERM=${TERM:-dumb}

command=`top -b -p 919 -n 1 | grep ipfs | awk '{$1=$1};1' | ts '[%Y-%m-%d %H:%M:%S]'`
echo $command
