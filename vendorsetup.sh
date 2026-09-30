#!/bin/bash
# Copyright (C) 2026 AERA Recovery Project contributors
# SPDX-License-Identifier: GPL-3.0-or-later

FDEVICE="myron"

aera_get_target_device() {
	local script_path
	script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
	if echo "$script_path" | grep -q "$FDEVICE"; then
		export AERA_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$AERA_BUILD_DEVICE" ]; then
	aera_get_target_device
fi

if [ "$1" = "$FDEVICE" ] || [ "$AERA_BUILD_DEVICE" = "$FDEVICE" ]; then
	export LC_ALL="C"
	export AERA_AB_DEVICE=1
	export AERA_VIRTUAL_AB_DEVICE=1
	export AERA_USE_TAR_BINARY=1
	export AERA_USE_SED_BINARY=1
	export AERA_USE_LZ4_BINARY=1
	export AERA_USE_ZSTD_BINARY=1
	export AERA_USE_DATE_BINARY=1
	export AERA_USE_GREP_BINARY=1
	export AERA_USE_BUSYBOX_BINARY=1
	export AERA_USE_XZ_UTILS=1
	export AERA_USE_FSCK_EROFS_BINARY=1
	export AERA_USE_PATCHELF_BINARY=1
	export AERA_USE_UPDATED_MAGISKBOOT=1
	export AERA_DELETE_AROMAFM=1
	export AERA_DELETE_MAGISK_ADDON=1
	export AERA_VANILLA_BUILD=1
	export AERA_PRODUCT_PREFIX=AERA
	export AERA_BUILD_STATUS=Unofficial
	export AERA_BUILD_TYPE=Beta
	export AERA_SETTINGS_ROOT_DIRECTORY=/data/recovery
	export AERA_MISCELLANEOUS_ROOT_DIRECTORY=/sdcard
	export AERA_ALLOW_EARLY_SETTINGS_LOAD=1
	export AERA_USE_DMSETUP=1
	export AERA_ENABLE_KERNELSU_SUPPORT=1
	export AERA_ENABLE_KERNELSU_NEXT_SUPPORT=1
	export AERA_ENABLE_SUKISU_SUPPORT=1

	export TARGET_DEVICE_ALT="myron"
	export AERA_TARGET_DEVICES="$TARGET_DEVICE_ALT"

	unset AERA_VARIANT
	unset AERA_MAINTAINER_PATCH_VERSION
fi
