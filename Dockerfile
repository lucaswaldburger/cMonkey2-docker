## Note: use 
#docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}") 
#to remove all used images

FROM ubuntu

RUN apt-get update
## Install python
RUN apt-get install software-properties-common -y && \
    #apt-get install python2.7 libpython2.7 -y && \
    apt-get install python3.6 libpython3.6 python3-pip -y && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 && \
    rm /usr/bin/python3 && \
    ln -s python3.6 /usr/bin/python3 && \
    rm /usr/bin/python && \
    ln -s python2.7 /usr/bin/python

## Install R
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/America/Seattle /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get update && apt-get install -y -q r-base 
RUN apt-get install -y -q r-base-dev

## Install MEME
RUN apt-get install curl -y
RUN curl http://meme-suite.org/meme-software/4.11.3/meme_4.11.3_1.tar.gz meme_4.11.3_1.tar.gz | tar zx
RUN cd meme_4.11.3 && \
     ./configure --prefix=$HOME/meme \
        --with-url=http://meme-suite.org \
        --enable-build-libxml2 \
        --enable-build-libxslt \
        --with-python=/usr/bin/python; \
     make; \
     make test; \
     make install
ENV PATH /root/meme/bin:$PATH

## Install cmonkey2
# Install from pip to get wokring dependencies
RUN pip3 install cmonkey2
# Install from github to get example data and usable directory for running from source
RUN apt-get install git -y
RUN git clone https://github.com/baliga-lab/cmonkey2 /home/cmonkey2

## Begin cmonkey run
WORKDIR /home/cmonkey2
CMD /bin/bash /home/data/run_cmonkey.sh