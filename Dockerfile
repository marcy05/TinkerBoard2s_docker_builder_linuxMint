FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ARG userid
ARG groupid
ARG username

# Install required packages for building Tinker Board 2 Android
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y git-core
RUN apt-get install -y gnupg
RUN apt-get install -y flex
RUN apt-get install -y bison
RUN apt-get install -y gperf
RUN apt-get install -y build-essential
RUN apt-get install -y zip
RUN apt-get install -y curl
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y gcc-multilib
RUN apt-get install -y g++-multilib
RUN apt-get install -y libc6-dev-i386
RUN apt-get install -y lib32ncurses5-dev
RUN apt-get install -y x11proto-core-dev
RUN apt-get install -y libx11-dev lib32z-dev
RUN apt-get install -y libgl1-mesa-dev
RUN apt-get install -y libxml2-utils
RUN apt-get install -y xsltproc
RUN apt-get install -y unzip
RUN apt-get install -y python
RUN apt-get install -y bc
RUN apt-get install -y liblz4-tool
RUN apt-get install -y m4
RUN apt-get install -y python-crypto
RUN apt-get install -y xz-utils
RUN apt-get install -y kmod
RUN apt-get install -y bison
RUN apt-get install -y flex
RUN apt-get install -y python3-dev
RUN apt-get install -y fontconfig
RUN apt-get install -y libssl-dev
RUN apt-get install -y parted
RUN apt-get install -y gawk
RUN apt-get install -y cpio
RUN apt-get install -y rsync

RUN apt-get update
RUN apt-get install -y dosfstools wget sudo

RUN wget http://launchpadlibrarian.net/343927385/device-tree-compiler_1.4.5-3_amd64.deb
RUN dpkg -i device-tree-compiler_1.4.5-3_amd64.deb
RUN rm device-tree-compiler_1.4.5-3_amd64.deb

RUN apt-get update
RUN apt-get install -y udev

RUN apt-get install -y openjdk-8-jdk

RUN groupadd -g $groupid $username && \
    useradd -m -u $userid -g $groupid $username && \
    echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo $username >/root/username

ENV HOME=/home/$username
ENV USER=$username
WORKDIR /source

ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /bin/bash -c "cd /source; /bin/bash -i"
