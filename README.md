This repository contains code for the project **Dissecting IPFS and Swarm to demystify distributed decentralized storage networks**

There are two parts in the project:

1. Analysis of an IPFS gateway dataset.

   - Published in the paper [Design and evaluation of IPFS: a storage layer for the decentralized web](https://dl.acm.org/doi/abs/10.1145/3544216.3544232).

   - Results regarding time series analysis, CID popularity, agent request and churn rate.
2. Monitor IPFS and Swarm clients
   - Run IPFS and Swarm client on VMs.
   - Monitor and analyze standard metrics and connected peers.



You can either download the data and run the notebooks yourself, or view the results in PDF in the corresponding notebook_output files.

# Dependencies

## Notebooks

To get started with the notebooks, you will need to have the following dependencies installed:

- Python 3
- Jupyter Notebook
- NumPy 1.21.2
- Pandas 1.3.4
- Plotly 5.6.0
- Scipy 1.7.1
- tqdm 4.62.3 (optional)

You can install these dependencies using `pip` or your preferred package manager. For example:

```
# Jupyter Notebook
pip install jupyter

# NumPy
pip install numpy
```

Once you have the dependencies installed, you can clone this repository and navigate to the `notebooks` directory to access the Jupyter notebooks.

## Data

The IPFS gateway dataset is available on IPFS with the CID: bafybeiftyvcar3vh7zua3xakxkb2h5ppo4giu5f3rkpsqgcfh7n7axxnsa

You can download the original log file. Then, run the Data_Cleaning notebook to get csv files.

## Monitoring

The experiments were conducted on two virtual machines with 2 vCPUs, 16GB RAM, and 50GB storage running Debian 10.

To reproduce the results, you will need to have the IPFS and Swarm clients installed on your system:

- IPFS-client 0.16.0 ([Install IPFS](https://docs.ipfs.tech/install/))
- Swarm Bee Client 1.8.2 ([Install Bee](https://docs.ethswarm.org/docs/installation/install/))

And, the following dependencies:

- top 3.3.15
- nethogs 0.8.5-2+b1

You can install these dependencies if not already installed using `sudo` or your preferred package manager. For example:

```
# nethogs
sudo apt install nethogs
```

# Monitoring Steps

## Connected Peers

To monitor the connected peers of the IPFS client, you can:

1. Start the IPFS client.

   ```
   ipfs daemon
   ```

2. Create shell script.

   ```
   touch peer_ipfs.sh
   chmod u+x peer_ipfs.sh
   ```

   Add the following:

   ```shell
   ipfs swarm peers | ts '[%Y-%m-%d %H:%M:%S]' >> ~/peer_ipfs.txt 2>&1
   ```

3. Open cron config

   ```
   crontab -e
   ```

   Add the following to schedule every 1min:

   ```
   * * * * * ~/peer_ipfs.sh
   ```

4. Start and stop cron

   ```
   sudo service cron start
   sudo service cron stop
   ```

For Swarm client, use `curl http://localhost:1635/peers ` in step 2, and modify other file names accordingly.

## Standard Metrics

To monitor the CPU/MEM usage of the IPFS client, you can:

1. Start the IPFS client.

   ```
   ipfs daemon
   ```

2. Find PID using top command.

   ```
   top
   ```

3. Create shell script.

   ```
   touch top_ipfs.sh
   chmod u+x top_ipfs.sh
   ```

   Add the following:

   ```shell
   command=`top -b -p PID -n 1 | grep ipfs | awk '{$1=$1};1' | ts '[%Y-%m-%d %H:%M:%S]'`
   echo $command
   ```

4. Open cron config

   ```
   crontab -e
   ```

   Add the following to schedule every 10s:

   ```
   * * * * * ~/top_ipfs.sh >> ~/top_ipfs.txt 2>&1
   * * * * * ( sleep 10 ; ~/top_ipfs.sh >> ~/top_ipfs.txt 2>&1 )
   * * * * * ( sleep 20 ; ~/top_ipfs.sh >> ~/top_ipfs.txt 2>&1 )
   * * * * * ( sleep 30 ; ~/top_ipfs.sh >> ~/top_ipfs.txt 2>&1 )
   * * * * * ( sleep 40 ; ~/top_ipfs.sh >> ~/top_ipfs.txt 2>&1 )
   * * * * * ( sleep 50 ; ~/top_ipfs.sh >> ~/top_ipfs.txt 2>&1 )
   ```

5. Start and stop cron

   ```
   sudo service cron start
   sudo service cron stop
   ```

For Swarm client, use `grep bee` in step 3, and modify other file names accordingly.

To measure network, change the shell script in setp 3:

```shell
command=`sudo nethogs -t -c 2 | grep ipfs | ts '[%Y-%m-%d %H:%M:%S]'`
echo $command
```

## Problems you may encounter

1. [how to remove "TERM environment variable not set"](https://stackoverflow.com/questions/19425727/how-to-remove-term-environment-variable-not-set)

   Sol: Set the variable in the script by adding a line to your shell script:

   ```
   export TERM=${TERM:-dumb}
   ```

2. ["command not found" when running a script via cron](https://askubuntu.com/questions/47800/command-not-found-when-running-a-script-via-cron)

   Sol: Run `echo "$PATH"` to get the `$PATH` variable.

   Put the line in the top of your shell script:

   ```
   export PATH="your path"
   ```
