export TERM=${TERM:-dumb}
export PATH="/home/sixiao/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

curl http://localhost:1635/peers | ts '[%Y-%m-%d %H:%M:%S]' >> ~/script/peer.txt 2>&1
