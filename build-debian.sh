#!/bin/bash

SRC=$(pwd)
set -e
set -e

#Requires root ..
if [ "$UID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#--------------------------------------------------------------------------------
# Downloading necessary files
#--------------------------------------------------------------------------------
echo "------ installing requirements"
sleep 3
apt-get -qq -y install binfmt-support bison build-essential ccache debootstrap flex gawk gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf gettext git linux-headers-generic linux-image-generic lvm2 qemu-user-static texinfo texlive u-boot-tools uuid-dev zlib1g-dev unzip libncurses5-dev pkg-config libusb-1.0-0-dev

# call main build script

$SRC/build.sh
