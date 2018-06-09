# android_device_xiaomi_polaris
For building TWRP for Xiaomi Mi MIX 2S

TWRP device tree for Xiaomi MIX 2S

Kernel and all blobs are extracted from miui_MIMIX2S_V9.5.12.0.ODGCNFA_28e7b5cf2e_8.0 firmware.

To compile

```bash
. build/envsetup.sh && lunch omni_polaris-eng && mka recoveryimage
```

The Xiaomi Mi MIX 2S (codenamed _"polaris"_) are high-end smartphones from Xiaomi.

Xiaomi Mi MIX 2S was announced and released in April 2018.

## Device specifications

| Device       | Xiaomi Mi MIX 2S                                |
| -----------: | :---------------------------------------------- |
| SoC          | Qualcomm SDM845 Snapdragon 845                  |
| CPU          | 8x Qualcomm® Kryo™ 385 up to 2.8GHz             |
| GPU          | Adreno 630                                      |
| Memory       | 6GB / 8GM RAM (LPDDR4X)                         |
| Shipped Android version | 8.0                                  |
| Storage      | 64GB / 128GB / 256GB UFS 2.1 flash storage      |
| Battery      | Non-removable Li-Po 3400 mAh                    |
| Dimensions   | 150.86 x 74.9 x 8.1 mm                          |
| Display      | 2160 x 1080 (18:9), 5.99 inch                   |
| Rear camera 1 | 12MP, f/1.8 Dual LED flash                     |
| Rear camera 2 | 12MP, f/2.4                                    |
| Front camera | 5MP, 1-micron pixels, f/2.2 1080p 30 fps video  |

## Device picture

![Xiaomi Mi MIX 2S](https://i1.mifile.cn/f/i/2018/mix2s/specs/black.png?1)

## Features

Works:

- ADB
- Decryption of /data
- Screen brightness settings
- Now UI is very smooth (thanks to TWRP fix 16d831bee5a660f5ac6da0d8fff2b3ec4697d663)
- Vibration on touch (see https://gerrit.omnirom.org/#/c/android_bootable_recovery/+/31021/)
- Correct screenshot color (see https://gerrit.omnirom.org/#/c/android_bootable_recovery/+/31042/)

## Compile

First checkout minimal twrp with omnirom tree:

```
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-8.1
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/polaris" name="notsyncing/android_device_xiaomi_polaris" remote="github" revision="android-8.1" />
```

Finally execute these:

```
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch omni_polaris-eng 
mka recoveryimage
```

To test it:

```
fastboot boot out/target/product/polaris/recovery.img
```

## Thanks

- @travismills82 for his TWRP tree used as skeleton: [twrp_android_device_samsung_star2qltechn](https://github.com/travismills82/twrp_android_device_samsung_star2qltechn)

- @TeamWin for sagit TWRP tree used for partial decryption works: [android_device_xiaomi_sagit](https://github.com/TeamWin/android_device_xiaomi_sagit)

- 宅科技_zecoki (or wx_pmZ7777t in the inner link), used for ADB works: [	
[Recovery] 小米 MIX2s TWRP recovery下载](https://blog.csdn.net/u010880477/article/details/80285813)
