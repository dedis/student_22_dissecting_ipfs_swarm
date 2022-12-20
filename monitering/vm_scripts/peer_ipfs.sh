export TERM=${TERM:-dumb}
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

ipfs swarm peers | ts '[%Y-%m-%d %H:%M:%S]' >> ~/script/peer.txt 2>&1
