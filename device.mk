#
# Copyright (C) 2026 AERA Recovery Project contributors
# Device: Xiaomi myron (POCO F8 Ultra / Redmi K90 Pro Max)
# Branch: AERA 16.0
# SoC   : Snapdragon 8 Elite Gen 5 (SM8850 / canoe)
#
# SPDX-License-Identifier: Apache-2.0
#
# v6 — PATCHED from ROM dump:
#   - service names corrected (vendor.keymint, vendor.weaver_nxp)
#   - se_omapi removed (OMAPI = Java app com.android.se on myron)
#   - all missing libs added from ROM dump
#   - libjc_weaver_transport.so / mi_weaver.so removed (not on ROM)
#

DEVICE_PATH := device/xiaomi/myron

# Shipping API level
BOARD_SHIPPING_API_LEVEL := 35
PRODUCT_SHIPPING_API_LEVEL := 35
PRODUCT_TARGET_VNDK_VERSION := 35
# The device uses 4 KiB pages, so disable the 16 KiB prebuilt alignment check.
PRODUCT_CHECK_PREBUILT_MAX_PAGE_SIZE := false
# ─── Dynamic partitions ───────────────────────────────────────────────────────
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_VIRTUAL_AB_OTA         := true

# ─── Fuse passthrough ─────────────────────────────────────────────────────────
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# ─── Soong namespaces ─────────────────────────────────────────────────────────
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# ___ Soong Fix
PRODUCT_APEX_SYSTEM_SERVER_JARS += com.android.crashrecovery:service-crashrecovery

# ─── lptools ──────────────────────────────────────────────────────────────────
PRODUCT_PACKAGES += \
    aera-audio-bridge \
    aera-audio-service \
    aera-browser-jail \
    lpflash \
    lpmake \
    lpunpack

# Myron uses the SM8850 Adreno 840 stack extracted from its matching stock
# image. Keep this device-scoped so AERA retains the software renderer on
# devices without a validated proprietary userspace/kernel pairing.
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl=adreno \
    vendor.gralloc.enable_snapalloc=1

# ─── Release key ──────────────────────────────────────────────────────────────
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/releasekey
