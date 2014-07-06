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

omap_next () {
	echo "dir: omap_next"
	#from: https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
	#git pull --no-edit git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts

	${git} "${DIR}/patches/omap_next/0001-ARM-OMAP2-hwmod-Change-hardreset-soc_ops-for-AM43XX.patch"
	${git} "${DIR}/patches/omap_next/0002-ARM-OMAP5-hwmod-Add-ocp2scp3-and-sata-hwmods.patch"
	${git} "${DIR}/patches/omap_next/0003-ARM-dts-Enable-twl4030-off-idle-configuration-for-se.patch"
	${git} "${DIR}/patches/omap_next/0004-ARM-DRA722-add-detection-of-SoC-information.patch"
	${git} "${DIR}/patches/omap_next/0005-ARM-dts-omap5-Update-CPU-OPP-table-as-per-final-prod.patch"
	${git} "${DIR}/patches/omap_next/0006-ARM-dts-am43x-epos-evm-Add-Missing-cpsw-phy-sel-for-.patch"
	${git} "${DIR}/patches/omap_next/0007-ARM-OMAP2-drop-unused-function.patch"
	${git} "${DIR}/patches/omap_next/0008-ARM-DTS-dra7-dra7xx-clocks-ATL-related-changes.patch"
	${git} "${DIR}/patches/omap_next/0009-ARM-OMAP2-Fix-parser-bug-in-platform-muxing-code.patch"
	${git} "${DIR}/patches/omap_next/0010-ARM-dts-dra7-evm-remove-interrupt-binding.patch"
}

tegra_next () {
	echo "dir: tegra_next"
	#From: https://git.kernel.org/cgit/linux/kernel/git/tegra/linux.git/log/?h=for-next
	#git pull --no-edit git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
}

dss () {
	echo "dir: dss"
}

sata () {
	echo "dir: sata"
}

fixes () {
	echo "dir: fixes"
	${git} "${DIR}/patches/fixes/0001-saucy-error-variable-ilace-set-but-not-used-Werror-u.patch"
}

#omap_next
fixes

packaging_setup () {
	cp -v "${DIR}/3rdparty/packaging/builddeb" "${DIR}/KERNEL/scripts/package"
	git commit -a -m 'packaging: sync with mainline' -s

	git format-patch -1 -o "${DIR}/patches/packaging"
}

packaging () {
	echo "dir: packaging"
	#${git} "${DIR}/patches/packaging/0001-packaging-sync-with-mainline.patch"
	${git} "${DIR}/patches/packaging/0002-deb-pkg-install-dtbs-in-linux-image-package.patch"
}

#packaging_setup
packaging
echo "patch.sh ran successful"
