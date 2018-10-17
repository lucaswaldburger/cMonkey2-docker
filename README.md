# cMonkey2-docker
Setting up cMonkey2 can give you monkey brain, use this docker file instead.

# Intro
cMonkey is a biclustering algorithm designed to identify co-regulated genes; biclusting refers to the goal of identifying coregulated genes (features) conditioned on experimental or environmental variables (variables). This leads to clusters of both features and conditions, rows and columns of the data matrix.  This can be applied to any data type where correlation of features and variables is of interest.  
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4513845/  

This code provides a dockerized version of the cMonkey2 code provided by the Baliga lab at ISB.
https://github.com/baliga-lab/cmonkey2/


# Setup
1. Install Docker if not already installed.
2. Clone this github repo.
3. Prepare RSAT files and place them in the same directory.
4. Prepare protein network files if appropriate and put them in the same directory.
5. Place the data file (a tab separated file), probably a gene response file, possibly expression ratios, or zscores, in the same directory.
6. Update the path to the data file (dataFile) in run_cmonkey.sh

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
