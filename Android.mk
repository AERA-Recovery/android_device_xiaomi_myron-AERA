#
# Copyright (C) 2026 AERA Recovery Project contributors
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),myron)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
