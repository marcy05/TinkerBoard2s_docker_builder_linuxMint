FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG userid
ARG groupid
ARG username

# Install required packages for building Tinker Board 2 Android
RUN apt-get update
RUN apt-get install -y python-is-python3
RUN apt-get install -y git git-core 
RUN apt-get install -y gnupg flex bison gperf 
RUN apt-get install -y build-essential zip curl zlib1g-dev 
RUN apt-get install -y gcc-multilib g++-multilib libc6-dev-i386 
RUN apt-get install -y lib32ncurses5-dev 
RUN apt-get install -y x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc 
RUN apt-get install -y unzip bc liblz4-tool m4 
# RUN apt-get install -y pycrypto 
RUN apt-get install -y xz-utils 
RUN apt-get install -y kmod 
RUN apt-get install -y bison 
RUN apt-get install -y flex python3-dev 
RUN apt-get install -y fontconfig libssl-dev 
RUN apt-get install -y parted gawk cpio rsync
RUN apt-get install -y gcc
RUN apt-get install -y pip
RUN pip install pycrypto

RUN apt-get update
RUN apt-get install -y dosfstools wget sudo

RUN wget http://launchpadlibrarian.net/343927385/device-tree-compiler_1.4.5-3_amd64.deb
RUN dpkg -i device-tree-compiler_1.4.5-3_amd64.deb
RUN rm device-tree-compiler_1.4.5-3_amd64.deb

RUN apt-get update
RUN apt-get install -y udev

RUN apt-get install -y openjdk-17-jdk

RUN groupadd -g $groupid $username && \
    useradd -m -u $userid -g $groupid $username && \
    echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo $username >/root/username

ENV HOME=/home/$username
ENV USER=$username
WORKDIR /source

ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /bin/bash -c "cd /source; /bin/bash -i"
