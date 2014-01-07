#!/bin/bash

SRC=$(pwd)
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

function aur {
	if ! pacman -Qi >>/dev/null 2>&1 $1
	then
		wget https://aur.archlinux.org/packages/${1:0:2}/$1/$1.tar.gz
		tar -xzf $1.tar.gz
		cd $1
		makepkg -s --asroot -f
		FILE=`ls | grep .pkg`
		pacman --noconfirm -U $FILE
	else
		echo installed: $1
	fi
}

mkdir -p $SRC/aur
cd $SRC/aur

pacman --needed --noconfirm -S bison ccache flex gawk gettext git linux-headers linux lvm2 texinfo texlive-bin util-linux zlib unzip ncurses pkg-config libusb base-devel elfutils libmpc ppl gmp qemu


aur cloog-ppl
aur libmpc09
aur binutils-arm-linux-gnueabihf-bin
aur libgcc-4.7-dev-armhf-cross
aur cpp-arm-linux-gnueabihf-bin
aur gcc-arm-linux-gnueabihf-bin
aur debootstrap
aur uboot-mkimage
#aur binfmt-support

# go back to original folder
cd $SRC

# call main build script
$SRC/build.sh
