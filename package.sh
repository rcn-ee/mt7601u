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
base_dir="./"

if [ -f ${base_dir}src/os/linux/mt7601Usta.ko ] ; then

	cp -v ${base_dir}src/os/linux/mt7601Usta.ko ${base_dir}
	cp -v ${base_dir}src/RT2870STA.dat ${base_dir}
	cp -v ${base_dir}src/README_STA_usb ${base_dir}

	#echo "mt7601Usta" > ${base_dir}mt7601.conf

	echo "Section: misc" > ${base_dir}control
	echo "Priority: optional" >> ${base_dir}control
	echo "Homepage: https://github.com/rcn-ee/${package}" >> ${base_dir}control
	echo "Standards-Version: 3.9.6" >> ${base_dir}control
	echo "" >> ${base_dir}control
	echo "Package: ${package}-modules-${uname_r}" >> ${base_dir}control
	echo "Version: 1${distro}" >> ${base_dir}control
	echo "Pre-Depends: linux-image-${uname_r}" >> ${base_dir}control
	echo "Maintainer: Robert Nelson <robertcnelson@gmail.com>" >> ${base_dir}control
	echo "Architecture: ${dpkg_arch}" >> ${base_dir}control
	echo "Readme: README_STA_usb" >> ${base_dir}control
	echo "Files: mt7601Usta.ko /lib/modules/${uname_r}/kernel/drivers/net/wireless/" >> ${base_dir}control
	#echo " RT2870STA.dat /etc/Wireless/RT2870STA/" >> ${base_dir}control
	#echo " mt7601.conf /etc/modules-load.d/" >> ${base_dir}control
	echo "Description: ${package} modules" >> ${base_dir}control
	echo " Kernel modules for ${package} devices" >> ${base_dir}control
	echo "" >> ${base_dir}control

	equivs-build control

	rm -rf mt7601Usta.ko || true
	rm -rf RT2870STA.dat || true
	rm -rf README_STA_usb || true
	#rm -rf mt7601.conf || true
	rm -rf control || true
fi
