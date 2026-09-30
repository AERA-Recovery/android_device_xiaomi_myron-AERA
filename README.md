# AERA Recovery for Xiaomi Myron

Local AERA 16 device bring-up for the POCO F8 Ultra / Redmi K90 Pro Max.
This testing tree is based on the original Myron recovery work by
haohao3001 and retains its device-specific kernel, modules, crypto services,
USB configuration and recovery-partition AVB helper.

## Device

- SoC: Snapdragon 8 Elite Gen 5 (SM8850 / canoe)
- Display: 1200x2608, 120 Hz OLED
- Kernel: GKI 6.12, 4 KiB pages
- Partition layout: Virtual A/B with dedicated slot-aware recovery partitions
- Encryption: FBE v2 with wrapped keys
- KeyMint: QTI TEE plus NXP/Thales StrongBox services
- Recovery partition size: 100 MiB

## Build

Place this tree at `device/xiaomi/myron`, then run:

```bash
source build/envsetup.sh
lunch twrp_myron-bp2a-eng
mka recoveryimage
```

The build is configured as an Unofficial Beta for local testing.

## Recovery AVB note

Devices using a relocked or pseudo-locked bootloader may require the stock
recovery AVB footer. The retained helper can transplant it:

```bash
python3 transplanting_vbmeta.py stock-recovery.img AERA-recovery.img output.img
```

## Expected initial feature set

- Display and touch
- Data decryption
- ADB, MTP and fastbootd
- AERA live recovery/fastbootd transition support
- Wi-Fi through AERA's source-built network userspace
- Backup, restore and logical-partition image flashing
- KernelSU, KernelSU Next and SukiSU support
- USB OTG and flashlight

Maintainer of the original Myron device work: haohao3001.
