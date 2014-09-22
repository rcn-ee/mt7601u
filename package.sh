#!/bin/bash

ARCH=$(uname -m)

if [ "x${ARCH}" = "xarmv7l" ] ; then
	uname_r="VERSION"
	distro="DISTRO"
	dpkg_arch="armhf"
else
	uname_r="3.14.19-ti-r24"
	distro="wheezy"
	dpkg_arch="amd64"
fi

package="mt7601u"

if [ -f ./src/os/linux/mt7601Usta.ko ] ; then
	cp -v ./src/os/linux/mt7601Usta.ko ./
	cp -v ./src/RT2870STA.dat ./
	cp -v ./src/README_STA_usb ./

	echo "mt7601Usta" > ./mt7601.conf

	echo "Section: misc" > ./control
	echo "Priority: optional" >> ./control
	echo "Homepage: https://github.com/rcn-ee/${package}" >> ./control
	echo "Standards-Version: 3.9.2" >> ./control
	echo "" >> ./control
	echo "Package: ${package}-modules-${uname_r}" >> ./control
	echo "Version: 1${distro}" >> ./control
	echo "Pre-Depends: linux-image-${uname_r}" >> ./control
	echo "Maintainer: Robert Nelson <robertcnelson@gmail.com>" >> ./control
	echo "Architecture: ${dpkg_arch}" >> ./control
	echo "Readme: README_STA_usb" >> ./control
	echo "Files: mt7601Usta.ko /lib/modules/${uname_r}/kernel/drivers/net/wireless/" >> ./control
	echo " RT2870STA.dat /etc/Wireless/RT2870STA/" >> ./control
	echo " mt7601.conf /etc/modules-load.d/" >> ./control
	echo "Description: ${package} modules" >> ./control
	echo " Kernel modules for ${package} devices" >> ./control
	echo "" >> ./control

	equivs-build control

	rm -rf mt7601Usta.ko || true
	rm -rf RT2870STA.dat || true
	rm -rf README_STA_usb || true
	rm -rf mt7601.conf || true
	rm -rf control || true
fi
