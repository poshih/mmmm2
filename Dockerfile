FROM nvidia/cuda:11.2.0-devel-ubuntu20.04

MAINTAINER nobody

WORKDIR /

ARG DEBIAN_FRONTEND=noninteractive

# Package and dependency setup
RUN apt update \
    && apt upgrade -y \    
    && apt-get install -y git \
     cmake \
     build-essential     
         
# Git repo set up
RUN git clone https://github.com/ethereum-mining/ethminer.git; \
    cd ethminer; \
    git submodule update --init --recursive; \
    mkdir build; \
    cd build; \
    cmake .. -DETHASHCUDA=ON -DETHASHCL=OFF -DETHSTRATUM=ON; \
    cmake --build .; \
    make install;	
    
ADD startup.sh /root/onstart.sh
RUN chmod +x /root/onstart.sh
    
#ENTRYPOINT ["startup.sh"]
