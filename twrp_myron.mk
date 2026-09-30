#
# Copyright (C) 2026 AERA Recovery Project contributors
# Device: Xiaomi myron (POCO F8 Ultra / Redmi K90 Pro Max)
# Branch: AERA 16.0
# SoC   : Snapdragon 8 Elite Gen 5 (SM8850 / sun)
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/myron
# ─── Inheritance ──────────────────────────────────────────────────────────────
# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit_only.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Configure virtual_ab compression.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Configure full_base_telephony.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Device hardware configuration
$(call inherit-product, device/xiaomi/myron/device.mk)

# AERA-specific recovery configuration
$(call inherit-product, device/xiaomi/myron/aera_myron.mk)

PRODUCT_DEVICE       := myron
PRODUCT_NAME         := twrp_myron
PRODUCT_BRAND        := Xiaomi
PRODUCT_MODEL        := REDMI K90 Pro Max
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="myron-user 16 BQ2A.250705.001-BP2A.250605.031.A3 OS3.0.303.0.WPMCNXM release-keys"

BUILD_FINGERPRINT := Redmi/myron/myron:16/BQ2A.250705.001-BP2A.250605.031.A3/OS3.0.303.0.WPMCNXM:user/release-keys

AERA_STATUS_ICONS_ALIGN := center
