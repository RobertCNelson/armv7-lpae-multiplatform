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
	#from: https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/

	${git} "${DIR}/patches/omap_next/0001-irqchip-crossbar-Dont-use-0-to-mark-reserved-interru.patch"
	${git} "${DIR}/patches/omap_next/0002-irqchip-crossbar-Check-for-premapped-crossbar-before.patch"
	${git} "${DIR}/patches/omap_next/0003-irqchip-crossbar-Introduce-ti-irqs-skip-to-skip-irqs.patch"
	${git} "${DIR}/patches/omap_next/0004-irqchip-crossbar-Initialise-the-crossbar-with-a-safe.patch"
	${git} "${DIR}/patches/omap_next/0005-irqchip-crossbar-Change-allocation-logic-by-reversin.patch"
	${git} "${DIR}/patches/omap_next/0006-irqchip-crossbar-Remove-IS_ERR_VALUE-check.patch"
	${git} "${DIR}/patches/omap_next/0007-irqchip-crossbar-Fix-sparse-and-checkpatch-warnings.patch"
	${git} "${DIR}/patches/omap_next/0008-irqchip-crossbar-Fix-kerneldoc-warning.patch"
	${git} "${DIR}/patches/omap_next/0009-irqchip-crossbar-Return-proper-error-value.patch"
	${git} "${DIR}/patches/omap_next/0010-irqchip-crossbar-Change-the-goto-naming.patch"
	${git} "${DIR}/patches/omap_next/0011-irqchip-crossbar-Set-cb-pointer-to-null-in-case-of-e.patch"
	${git} "${DIR}/patches/omap_next/0012-irqchip-crossbar-Add-kerneldoc-for-crossbar_domain_u.patch"
	${git} "${DIR}/patches/omap_next/0013-irqchip-crossbar-Introduce-ti-max-crossbar-sources-t.patch"
	${git} "${DIR}/patches/omap_next/0014-irqchip-crossbar-Introduce-centralized-check-for-cro.patch"
	${git} "${DIR}/patches/omap_next/0015-documentation-dt-omap-crossbar-Add-description-for-i.patch"
	${git} "${DIR}/patches/omap_next/0016-irqchip-crossbar-Allow-for-quirky-hardware-with-dire.patch"
	${git} "${DIR}/patches/omap_next/0017-ARM-dts-am4372-let-boards-access-all-nodes-through-l.patch"
	${git} "${DIR}/patches/omap_next/0018-ARM-dts-add-support-for-AM437x-StarterKit.patch"
	${git} "${DIR}/patches/omap_next/0019-ARM-OMAP2-convert-sys_ck-and-osc_ck-to-standard-cloc.patch"
	${git} "${DIR}/patches/omap_next/0020-ARM-dts-am335x-evmsk-enable-display-and-lcd-panel-su.patch"
	${git} "${DIR}/patches/omap_next/0021-ARM-OMAP2420-clock-get-rid-of-fixed-div-property-use.patch"
	${git} "${DIR}/patches/omap_next/0022-ARM-OMAP2-PRM-add-support-for-OMAP2-specific-clock-p.patch"
	${git} "${DIR}/patches/omap_next/0023-ARM-OMAP2-clock-use-DT-clock-boot-if-available.patch"
	${git} "${DIR}/patches/omap_next/0024-ARM-OMAP24xx-clock-remove-legacy-clock-data.patch"
	${git} "${DIR}/patches/omap_next/0025-ARM-dts-dra7-add-routable-irqs-property-for-gic-node.patch"
	${git} "${DIR}/patches/omap_next/0026-ARM-dts-dra7-add-crossbar-device-binding.patch"
	${git} "${DIR}/patches/omap_next/0027-ARM-dts-Add-devicetree-for-Gumstix-Pepper-board.patch"
	${git} "${DIR}/patches/omap_next/0028-ARM-dts-AM43x-Add-TPS65218-device-tree-nodes.patch"
	${git} "${DIR}/patches/omap_next/0029-ARM-dts-AM437x-Fix-i2c-nodes-indentation.patch"
	${git} "${DIR}/patches/omap_next/0030-ARM-dts-AM437x-Add-TPS65218-device-tree-nodes.patch"
	${git} "${DIR}/patches/omap_next/0031-ARM-omap2plus_defconfig-enable-TPS65218-configs.patch"
	${git} "${DIR}/patches/omap_next/0032-ARM-dts-dra7-evm-Add-regulator-information-to-USB2-P.patch"
	${git} "${DIR}/patches/omap_next/0033-ARM-dts-dra7xx-clocks-Add-divider-table-to-optfclk_p.patch"
	${git} "${DIR}/patches/omap_next/0034-ARM-dts-dra7xx-clocks-Change-the-parent-of-apll_pcie.patch"
	${git} "${DIR}/patches/omap_next/0035-ARM-dts-dra7xx-clocks-Add-missing-32KHz-clocks-used-.patch"
	${git} "${DIR}/patches/omap_next/0036-ARM-dts-dra7xx-clocks-rename-pcie-clocks-to-accommod.patch"
	${git} "${DIR}/patches/omap_next/0037-ARM-dts-dra7xx-clocks-Add-missing-clocks-for-second-.patch"
	${git} "${DIR}/patches/omap_next/0038-ARM-dts-dra7-Add-dt-data-for-PCIe-PHY-control-module.patch"
	${git} "${DIR}/patches/omap_next/0039-ARM-dts-dra7-Add-dt-data-for-PCIe-PHY.patch"
	${git} "${DIR}/patches/omap_next/0040-ARM-dts-dra7-Add-dt-data-for-PCIe-controller.patch"
	${git} "${DIR}/patches/omap_next/0041-ARM-DTS-omap5-uevm-Enable-palmas-clk32kgaudio-clock.patch"
	${git} "${DIR}/patches/omap_next/0042-ARM-DTS-omap5-uevm-Add-node-for-twl6040-audio-codec.patch"
	${git} "${DIR}/patches/omap_next/0043-ARM-DTS-omap5-uevm-Enable-basic-audio-McPDM-twl6040.patch"
}

tegra_next () {
	echo "dir: tegra_next"
	#From: https://git.kernel.org/cgit/linux/kernel/git/tegra/linux.git/log/?h=for-next
	#git pull --no-edit git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next

	${git} "${DIR}/patches/tegra_next/0001-ARM-tegra-rebuild-tegra_defconfig.patch"
	${git} "${DIR}/patches/tegra_next/0002-ARM-dts-Create-a-cros-ec-keyboard-fragment.patch"
	${git} "${DIR}/patches/tegra_next/0003-ARM-tegra-Use-the-cros-ec-keyboard-fragment-in-venic.patch"
	${git} "${DIR}/patches/tegra_next/0004-ARM-dts-Use-the-cros-ec-keyboard-fragment-in-exynos5.patch"
	${git} "${DIR}/patches/tegra_next/0005-PCI-tegra-Overhaul-regulator-usage.patch"
	${git} "${DIR}/patches/tegra_next/0006-ARM-tegra-Add-new-PCIe-regulator-properties.patch"
	${git} "${DIR}/patches/tegra_next/0007-kernel-add-calibration_delay_done.patch"
	${git} "${DIR}/patches/tegra_next/0008-ARM-choose-highest-resolution-delay-timer.patch"
	${git} "${DIR}/patches/tegra_next/0009-clocksource-tegra-Use-us-counter-as-delay-timer.patch"
	${git} "${DIR}/patches/tegra_next/0010-ARM-tegra-enable-igb-stmpe-i2c-chardev-lm95245-pwm-l.patch"
	${git} "${DIR}/patches/tegra_next/0011-of-Add-NVIDIA-Tegra-XUSB-pad-controller-binding.patch"
	${git} "${DIR}/patches/tegra_next/0012-pinctrl-Add-NVIDIA-Tegra-XUSB-pad-controller-support.patch"
	${git} "${DIR}/patches/tegra_next/0013-ARM-tegra-Move-includes-to-include-soc-tegra.patch"
	${git} "${DIR}/patches/tegra_next/0014-ARM-tegra-Sort-includes-alphabetically.patch"
	${git} "${DIR}/patches/tegra_next/0015-ARM-tegra-Use-a-function-to-get-the-chip-ID.patch"
	${git} "${DIR}/patches/tegra_next/0016-ARM-tegra-export-apb-dma-readl-writel.patch"
	${git} "${DIR}/patches/tegra_next/0017-ARM-tegra-move-fuse-exports-to-soc-tegra-fuse.h.patch"
	${git} "${DIR}/patches/tegra_next/0018-soc-tegra-Add-efuse-driver-for-Tegra.patch"
	${git} "${DIR}/patches/tegra_next/0019-soc-tegra-Add-efuse-and-apbmisc-bindings.patch"
	${git} "${DIR}/patches/tegra_next/0020-soc-tegra-fuse-move-APB-DMA-into-Tegra20-fuse-driver.patch"
	${git} "${DIR}/patches/tegra_next/0021-soc-tegra-fuse-fix-dummy-functions.patch"
	${git} "${DIR}/patches/tegra_next/0022-soc-tegra-Implement-runtime-check-for-Tegra-SoCs.patch"
	${git} "${DIR}/patches/tegra_next/0023-ARM-tegra-Setup-CPU-hotplug-in-a-pure-initcall.patch"
	${git} "${DIR}/patches/tegra_next/0024-ARM-tegra-Always-lock-the-CPU-reset-vector.patch"
	${git} "${DIR}/patches/tegra_next/0025-soc-tegra-fuse-Set-up-in-early-initcall.patch"
	${git} "${DIR}/patches/tegra_next/0026-ARM-tegra-Convert-PMC-to-a-driver.patch"
	${git} "${DIR}/patches/tegra_next/0027-ARM-tegra-Add-the-EC-i2c-tunnel-to-tegra124-venice2.patch"
	${git} "${DIR}/patches/tegra_next/0028-ARM-tegra-Add-Tegra124-HDA-support.patch"
	${git} "${DIR}/patches/tegra_next/0029-ARM-tegra-venice2-Enable-HDA.patch"
	${git} "${DIR}/patches/tegra_next/0030-ARM-tegra-jetson-tk1-mark-eMMC-as-non-removable.patch"
	${git} "${DIR}/patches/tegra_next/0031-ARM-tegra-initial-support-for-apalis-t30.patch"
	${git} "${DIR}/patches/tegra_next/0032-ARM-tegra-tamonten-add-the-base-board-regulators.patch"
	${git} "${DIR}/patches/tegra_next/0033-ARM-tegra-tamonten-add-the-display-to-the-Medcom-Wid.patch"
	${git} "${DIR}/patches/tegra_next/0034-ARM-tegra-Migrate-Apalis-T30-PCIe-power-supply-schem.patch"
	${git} "${DIR}/patches/tegra_next/0035-ARM-tegra-roth-fix-unsupported-pinmux-properties.patch"
	${git} "${DIR}/patches/tegra_next/0036-ARM-tegra-roth-enable-input-on-mmc-clock-pins.patch"
	${git} "${DIR}/patches/tegra_next/0037-ARM-tegra-of-add-GK20A-device-tree-binding.patch"
	${git} "${DIR}/patches/tegra_next/0038-ARM-tegra-add-GK20A-GPU-to-Tegra124-DT.patch"
	${git} "${DIR}/patches/tegra_next/0039-ARM-tegra-tegra124-Add-XUSB-pad-controller.patch"
	${git} "${DIR}/patches/tegra_next/0040-ARM-tegra-jetson-tk1-Add-XUSB-pad-controller.patch"
	${git} "${DIR}/patches/tegra_next/0041-ARM-tegra-Fix-typoed-ams-ext-control-properties.patch"
	${git} "${DIR}/patches/tegra_next/0042-ARM-tegra-roth-add-display-DT-node.patch"
	${git} "${DIR}/patches/tegra_next/0043-PCI-tegra-Implement-accurate-power-supply-scheme.patch"
	${git} "${DIR}/patches/tegra_next/0044-PCI-tegra-Remove-deprecated-power-supply-properties.patch"
	${git} "${DIR}/patches/tegra_next/0045-ARM-tegra-Remove-legacy-PCIe-power-supply-properties.patch"
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

omap_next
tegra_next
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
	#${git} "${DIR}/patches/packaging/0003-deb-pkg-no-dtbs_install.patch"
}

#packaging_setup
packaging
echo "patch.sh ran successfully"
