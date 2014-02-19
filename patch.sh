#!/bin/sh
#
# Copyright (c) 2009-2013 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

git="git am"

if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

start_cleanup () {
	git="git am --whitespace=fix"
}

cleanup () {
	if [ "${number}" ] ; then
		git format-patch -${number} -o ${DIR}/patches/
	fi
	exit
}

clock () {
	echo "dir: clock"
	${git} "${DIR}/patches/clock/0001-clk-ti-am335x-remove-unecessary-cpu0-clk-node.patch"
	${git} "${DIR}/patches/clock/0002-ARM-dts-OMAP3-add-clock-nodes-for-CPU.patch"

	${git} "${DIR}/patches/clock/0003-ARM-dts-OMAP36xx-Add-device-node-for-ABB.patch"
	${git} "${DIR}/patches/clock/0004-ARM-dts-OMAP4-Add-device-nodes-for-ABB.patch"
	${git} "${DIR}/patches/clock/0005-ARM-dts-OMAP5-Add-device-nodes-for-ABB.patch"
	${git} "${DIR}/patches/clock/0006-ARM-dts-DRA7-Add-device-nodes-for-ABB.patch"
}

usb () {
	echo "dir: usb"
	${git} "${DIR}/patches/usb/0001-mfd-omap-usb-host-Use-resource-managed-clk_get.patch"
	${git} "${DIR}/patches/usb/0002-mfd-omap-usb-host-Get-clocks-based-on-hardware-revis.patch"
	${git} "${DIR}/patches/usb/0003-mfd-omap-usb-host-Use-clock-names-as-per-function-fo.patch"
	${git} "${DIR}/patches/usb/0004-mfd-omap-usb-host-Update-DT-clock-binding-informatio.patch"
	${git} "${DIR}/patches/usb/0005-mfd-omap-usb-tll-Update-DT-clock-binding-information.patch"
	${git} "${DIR}/patches/usb/0006-ARM-dts-omap4-Update-omap-usb-host-node.patch"
	${git} "${DIR}/patches/usb/0007-ARM-dts-omap5-Update-omap-usb-host-node.patch"
	${git} "${DIR}/patches/usb/0008-ARM-dts-omap4-panda-Provide-USB-PHY-clock.patch"
	${git} "${DIR}/patches/usb/0009-ARM-dts-omap5-uevm-Provide-USB-PHY-clock.patch"
	${git} "${DIR}/patches/usb/0010-ARM-OMAP2-Remove-legacy_init_ehci_clk.patch"
	${git} "${DIR}/patches/usb/0011-ARM-dts-OMAP2-Get-rid-of-incompatible-ids-for-USB-ho.patch"
	${git} "${DIR}/patches/usb/0012-usb-omap-dts-Update-DT-binding-example-usage.patch"
}

fixes () {
	echo "dir: fixes"
	${git} "${DIR}/patches/fixes/0001-ARM-OMAP5-Fix-reboot-handling.patch"
}

clock
usb
fixes

echo "patch.sh ran successful"
