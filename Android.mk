#
# Copyright (C) 2026 AERA Recovery Project contributors
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),myron)
# Myron supplies real ODM directories in its recovery overlay. Do not copy
# Android's generic /odm -> /vendor/odm fallback children over those directories
# on incremental builds. Keep the existing recovery SELinux exclusions intact;
# this target-local addition affects only this device's ramdisk assembly.
$(PRODUCT_OUT)/obj/PACKAGING/recovery_intermediates/ramdisk_files-timestamp: IGNORE_RECOVERY_SEPOLICY += --exclude=/root/odm

include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
