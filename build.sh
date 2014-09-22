#!/bin/bash

ARCH=$(uname -m)

x86_dir="/opt/github/ti-linux-kernel-dev"
x86_compiler="gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/arm-linux-gnueabihf-"

if [ "x${ARCH}" = "xarmv7l" ] ; then
	make ARCH=arm CROSS_COMPILE= LINUX_SRC=/build/buildd/linux-src all
else
	make ARCH=arm CROSS_COMPILE=${x86_dir}/dl/${x86_compiler} LINUX_SRC=${x86_dir}/KERNEL all
fi
#
