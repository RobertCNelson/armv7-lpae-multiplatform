#!/bin/sh
#
# Copyright (c) 2009-2014 Robert Nelson <robertcnelson@gmail.com>
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

. ${DIR}/version.sh
if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

git="git am"
#git_patchset=""
#git_opts

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

external_git () {
	git_tag=""
	echo "pulling: ${git_tag}"
	git pull ${git_opts} ${git_patchset} ${git_tag}
}

local_patch () {
	echo "dir: dir"
	${git} "${DIR}/patches/dir/0001-patch.patch"
}

#external_git
#local_patch

x15 () {
	echo "dir: x15"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		#start_cleanup
		git checkout v3.18-rc2 -b tmp
		git pull --no-edit https://github.com/nmenon/linux-2.6-playground.git upstream/v3.18/x15
		git format-patch -10 -o "${DIR}/patches/x15/"
		git checkout master -f
		git branch -D tmp
		exit
	fi

	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		start_cleanup
	fi

	${git} "${DIR}/patches/x15/0001-omap2plus_defconfig-enable-the-usual-drivers.patch"
	${git} "${DIR}/patches/x15/0002-ARM-dts-Add-am57xx-beagle-x15.patch"
	${git} "${DIR}/patches/x15/0003-ARM-dts-dra7-Add-CPSW-and-MDIO-module-nodes-for-dra7.patch"
	${git} "${DIR}/patches/x15/0004-ARM-dts-am57xx-beagle-x15-Add-dual-ethernet.patch"
	${git} "${DIR}/patches/x15/0005-extcon-gpio-Convert-the-driver-to-use-gpio-desc-API-.patch"
	${git} "${DIR}/patches/x15/0006-extcon-gpio-Add-dt-support-for-the-driver.patch"
	${git} "${DIR}/patches/x15/0007-extcon-gpio-Always-use-gpio_get_value_cansleep.patch"
	${git} "${DIR}/patches/x15/0008-extcon-gpio-Add-support-for-using-cable-names.patch"
	${git} "${DIR}/patches/x15/0009-ARM-dts-dra7-Add-labels-to-DWC3-nodes.patch"
	${git} "${DIR}/patches/x15/0010-ARM-dts-beagle_x15-add-missing-extcon-for-USB-gadget.patch"

	if [ "x${regenerate}" = "xenable" ] ; then
		number=10
		cleanup
	fi
}

omap_next () {
	echo "dir: omap_next"
	#from: https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/
}

tegra_next () {
	echo "dir: tegra_next"
	#From: https://git.kernel.org/cgit/linux/kernel/git/tegra/linux.git/log/?h=for-next
	#git pull --no-edit git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
}

dts () {
	echo "dir: dts"
}

x15
#omap_next
#tegra_next
dts

packaging_setup () {
	cp -v "${DIR}/3rdparty/packaging/builddeb" "${DIR}/KERNEL/scripts/package"
	git commit -a -m 'packaging: sync with mainline' -s

	git format-patch -1 -o "${DIR}/patches/packaging"
}

packaging () {
	echo "dir: packaging"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		start_cleanup
	fi
	#${git} "${DIR}/patches/packaging/0001-packaging-sync-with-mainline.patch"
	${git} "${DIR}/patches/packaging/0002-deb-pkg-install-dtbs-in-linux-image-package.patch"
	#${git} "${DIR}/patches/packaging/0003-deb-pkg-no-dtbs_install.patch"

	if [ "x${regenerate}" = "xenable" ] ; then
		number=3
		cleanup
	fi
}

#packaging_setup
packaging
echo "patch.sh ran successfully"
