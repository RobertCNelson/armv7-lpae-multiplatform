#!/bin/sh -e

DIR=$PWD

check_config_value () {
	unset test_config
	test_config=$(grep "${config}=" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		echo "echo ${config}=${value} >> ./KERNEL/.config"
	else
		if [ ! "x${test_config}" = "x${config}=${value}" ] ; then
			echo "sed -i -e 's:${test_config}:${config}=${value}:g' ./KERNEL/.config"
		fi
	fi
}

check_config_builtin () {
	unset test_config
	test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		echo "echo ${config}=y >> ./KERNEL/.config"
	fi
}

check_config_module () {
	unset test_config
	test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${config}=y" ] ; then
		echo "sed -i -e 's:${config}=y:${config}=m:g' ./KERNEL/.config"
	else
		unset test_config
		test_config=$(grep "${config}=" ${DIR}/patches/defconfig || true)
		if [ "x${test_config}" = "x" ] ; then
			echo "echo ${config}=m >> ./KERNEL/.config"
		fi
	fi
}

check_config () {
	unset test_config
	test_config=$(grep "${config}=" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		echo "echo ${config}=y >> ./KERNEL/.config"
		echo "echo ${config}=m >> ./KERNEL/.config"
	fi
}

check_config_disable () {
	unset test_config
	test_config=$(grep "${config} is not set" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		unset test_config
		test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
		if [ "x${test_config}" = "x${config}=y" ] ; then
			echo "sed -i -e 's:${config}=y:# ${config} is not set:g' ./KERNEL/.config"
		else
			echo "sed -i -e 's:${config}=m:# ${config} is not set:g' ./KERNEL/.config"
		fi
	fi
}

check_if_set_then_set_module () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_module
	fi
}

check_if_set_then_set () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_builtin
	fi
}

check_if_set_then_disable () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_disable
	fi
}

#Support for actual hardware:
#
# Kernel Performance Events And Counters
#
config="CONFIG_CC_STACKPROTECTOR"
check_config_builtin
config="CONFIG_CC_STACKPROTECTOR_NONE"
check_config_disable
config="CONFIG_CC_STACKPROTECTOR_REGULAR"
check_config_builtin

#
# CPU Frequency scaling
#
config="CONFIG_CPU_FREQ_STAT"
check_config_builtin
config="CONFIG_CPU_FREQ_STAT_DETAILS"
check_config_builtin
config="CONFIG_CPU_FREQ_GOV_POWERSAVE"
check_config_builtin
config="CONFIG_CPU_FREQ_GOV_USERSPACE"
check_config_builtin
config="CONFIG_CPU_FREQ_GOV_ONDEMAND"
check_config_builtin
config="CONFIG_CPU_FREQ_GOV_CONSERVATIVE"
check_config_builtin
config="CONFIG_GENERIC_CPUFREQ_CPU0"
check_config_builtin

#
# ARM CPU frequency scaling drivers
#
config="CONFIG_ARM_OMAP2PLUS_CPUFREQ"
check_config_disable

#
# At least one emulation must be selected
#
config="CONFIG_KERNEL_MODE_NEON"
check_config_builtin

#
# Non-8250 serial port support
#
config="CONFIG_SERIAL_OMAP"
check_config_builtin
config="CONFIG_SERIAL_OMAP_CONSOLE"
check_config_builtin

#
# Pin controllers
#
config="CONFIG_PINCTRL_SINGLE"
check_config_builtin
config="CONFIG_PINCTRL_PALMAS"
check_config_builtin

#
# MODULbus GPIO expanders:
#
config="CONFIG_GPIO_PALMAS"
check_config_builtin

#
# Texas Instruments thermal drivers
#
config="CONFIG_TI_SOC_THERMAL"
check_config_builtin
config="CONFIG_TI_THERMAL"
check_config_builtin
config="CONFIG_OMAP5_THERMAL"
check_config_builtin

#
# Watchdog Device Drivers
#
config="CONFIG_OMAP_WATCHDOG"
check_config_builtin
config="CONFIG_TWL4030_WATCHDOG"
check_config_builtin

#
# Multifunction device drivers
#
config="CONFIG_MFD_PALMAS"
check_config_builtin
config="CONFIG_REGULATOR_PALMAS"
check_config_builtin
config="CONFIG_REGULATOR_TI_ABB"
check_config_builtin

#
# MMC/SD/SDIO Host Controller Drivers
#
config="CONFIG_MMC_OMAP"
check_config_builtin
config="CONFIG_MMC_OMAP_HS"
check_config_builtin

#
# I2C RTC drivers
#
config="CONFIG_RTC_DRV_PALMAS"
check_config_module

#
# File systems
#
config="CONFIG_EXT4_FS"
check_config_builtin

#Either no Hardware or not A7/A12/A15 with LPAE/etc..
#
# CPU Core family selection
#
config="CONFIG_ARCH_MVEBU"
check_config_disable
config="CONFIG_ARCH_HIGHBANK"
check_config_disable
config="CONFIG_ARCH_MXC"
check_config_disable
config="CONFIG_ARCH_OMAP3"
check_config_disable
config="CONFIG_ARCH_OMAP4"
check_config_disable
config="CONFIG_SOC_AM33XX"
check_config_disable


#fixes:
echo "#Bugs:"
config="CONFIG_XEN"
check_config_disable

config="CONFIG_ATH9K_HW"
check_config_disable
config="CONFIG_ATH9K_COMMON"
check_config_disable
config="CONFIG_ATH9K_BTCOEX_SUPPORT"
check_config_disable
config="CONFIG_ATH9K"
check_config_disable
config="CONFIG_ATH9K_HTC"
check_config_disable
#
