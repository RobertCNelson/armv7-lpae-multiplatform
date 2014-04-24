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

dss () {
	echo "dir: dss"
	${git} "${DIR}/patches/dss/0001-OMAPDSS-panel-dpi-Add-DT-support.patch"
	${git} "${DIR}/patches/dss/0002-Doc-DT-Add-DT-binding-documentation-for-MIPI-DPI-Pan.patch"
	${git} "${DIR}/patches/dss/0003-OMAPDSS-connector-hdmi-hpd-support.patch"
	${git} "${DIR}/patches/dss/0004-Doc-DT-hdmi-connector-add-HPD-GPIO-documentation.patch"
	${git} "${DIR}/patches/dss/0005-OMAPDSS-HDMI-lane-config-support.patch"
	${git} "${DIR}/patches/dss/0006-Doc-DT-ti-omap4-dss-hdmi-lanes.patch"
	${git} "${DIR}/patches/dss/0007-OMAPDSS-HDMI4-set-regulator-voltage-to-1.8V.patch"
	${git} "${DIR}/patches/dss/0008-OMAPDSS-DSI-set-regulator-voltage-to-1.8V.patch"
	${git} "${DIR}/patches/dss/0009-ARM-OMAP-hwmod-OMAP5-DSS-hwmod-data.patch"
	${git} "${DIR}/patches/dss/0010-ARM-OMAP-add-OMAP5-DSI-muxing.patch"
	${git} "${DIR}/patches/dss/0011-ARM-OMAP-add-detection-of-omap5-dss.patch"
	${git} "${DIR}/patches/dss/0012-ARM-dts-omap5-clocks.dtsi-add-dss-iclk.patch"
	${git} "${DIR}/patches/dss/0013-ARM-dts-omap5-clocks.dtsi-add-ti-set-rate-parent-to-.patch"
	${git} "${DIR}/patches/dss/0014-ARM-dts-omap5.dtsi-add-DSS-nodes.patch"
	${git} "${DIR}/patches/dss/0015-ARM-dts-omap5-uevm.dts-add-tca6424a.patch"
	${git} "${DIR}/patches/dss/0016-ARM-dts-omap5-uevm.dts-add-display-nodes.patch"
	${git} "${DIR}/patches/dss/0017-OMAPDSS-DSS-DISPC-DT-support-for-OMAP5.patch"
	${git} "${DIR}/patches/dss/0018-OMAPDSS-features-fix-OMAP5-features.patch"
	${git} "${DIR}/patches/dss/0019-OMAPDSS-DPI-fix-LCD3-DSI-source.patch"
	${git} "${DIR}/patches/dss/0020-OMAPDSS-DSI-Add-OMAP5-DSI-module-IDs.patch"
	${git} "${DIR}/patches/dss/0021-OMAPDSS-HDMI-improve-Makefile.patch"
	${git} "${DIR}/patches/dss/0022-OMAPDSS-HDMI-move-irq-phy-pwr-handling.patch"
	${git} "${DIR}/patches/dss/0023-OMAPDSS-HDMI-support-larger-register-offsets-for-OMA.patch"
	${git} "${DIR}/patches/dss/0024-OMAPDSS-HDMI-PHY-changes-for-OMAP5.patch"
	${git} "${DIR}/patches/dss/0025-OMAPDSS-HDMI-PLL-changes-for-OMAP5.patch"
	${git} "${DIR}/patches/dss/0026-OMAPDSS-HDMI-Add-OMAP5-HDMI-support.patch"
	${git} "${DIR}/patches/dss/0027-Doc-DT-Add-OMAP5-DSS-DT-bindings.patch"
}

fixes () {
	echo "dir: fixes"
#	${git} "${DIR}/patches/fixes/0001-ARM-OMAP5-Fix-reboot-handling.patch"
}

dss

echo "patch.sh ran successful"
