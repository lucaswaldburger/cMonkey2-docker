# cMonkey2-docker
Setting up cMonkey2 can give you monkey brain, use this docker file instead.

# Setup
1. Install Docker if not already installed.
2. Clone this github repo.
3. Prepare RSAT files and place them in the same directory.
4. Prepare protein network files if appropriate and put them in the same directory.
5. Place the data file, probably a gene response file, possibly expression ratios, or zscores, in the same directory.

# Running cMonkey2
## Start docker and build the docker image
Note: On AWS linux running centos sudo is required to issue docker commands.

sudo systemctl start docker

sudo docker build -t cmonkey:0.1 -f Dockerfile context

## Start docker container and auto run cMonkey2
The following command can be issued inside a screen window to facilitate also calling another instance for monitoring.  Alternatively the -d option could be used to run in detached mode.

sudo docker run --rm -it -v $(pwd):/home/data cmonkey:0.1

## Start web based monitor
The following command can be issued in a separate screen window to start the cm2view monitor while allowing monitoring of the cMonkey verbose output in the other screen window.

sudo docker run --rm -it -p 8080:8080 -v $(pwd):/home/data cmonkey:0.1 bash

bin/cm2view.sh --out ../data/results
