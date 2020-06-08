# android_device_xiaomi_umi
For building TWRP for Xiaomi Mi 10 / 10 Pro

TWRP device tree for Xiaomi Mi 10 and Mi 10 Pro

Kernel and all blobs are extracted from [miui_UMI_20.5.24_096a7991fe_10.0](https://bigota.d.miui.com/20.5.24/miui_UMI_20.5.24_096a7991fe_10.0.zip) firmware.

The Xiaomi Mi 10 (codenamed _"umi"_) and Xiaomi Mi 10 Pro (codenamed _"cmi"_) are high-end smartphones from Xiaomi.

Xiaomi Mi 10 / 10 Pro was announced and released in February 2020.

## Device specifications

| Device       | Xiaomi Mi 10 / 10 Pro                       |
| -----------: | :------------------------------------------ |
| SoC          | Qualcomm SM8250 Snapdragon 865              |
| CPU          | 8x Qualcomm® Kryo™ 585 up to 2.84GHz        |
| GPU          | Adreno 630                                  |
| Memory       | 8GB / 12GB RAM (LPDDR5)                     |
| Shipped Android version | 10                               |
| Storage      | 128GB / 256GB / 512GB UFS 3.0 flash storage |
| Battery      | Non-removable Li-Po 4780mAh                 |
| Dimensions   | 162.58 x 74.8 x 8.96 mm                     |
| Display      | 2340 x 1080 (19.5:9), 6.67 inch             |

## Device picture

![Xiaomi Mi 10](https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1581494372.61732687.jpg)

## Features

**Works**

- Booting.
- [Decryption](https://github.com/simonsmh/android_bootable_recovery/commits/android-10.0).
- ADB
- MTP
- Super partition functions
- Vibration

**Not Working**
- OTG

Mi 10 is using Dynamic Partition! We need update from TWRP.

## Compile

First checkout minimal twrp with omnirom tree:

```
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-10.0
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/umi" name="TeamWin/android_device_xiaomi_umi" remote="github" revision="android-10.0" />
```

Finally execute these:

```
. build/envsetup.sh
lunch omni_umi-eng
mka recoveryimage ALLOW_MISSING_DEPENDENCIES=true # Only if you use minimal twrp tree.
```

To test it:

```
fastboot boot out/target/product/umi/recovery.img
```

## Thanks
- [FsCrypt fix by mauronofrio](https://github.com/mauronofrio/android_bootable_recovery)
- [Decryption by bigbiff](https://github.com/bigbiff/android_bootable_recovery)
- [Oneplus 8 TWRP by mauronofrio](https://github.com/mauronofrio/android_device_oneplus_instantnoodle_TWRP)
