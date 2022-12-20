export TERM=${TERM:-dumb}

command=`top -b -p 27413 -n 1 | grep bee | awk '{$1=$1};1' | ts '[%Y-%m-%d %H:%M:%S]'`
echo $command
