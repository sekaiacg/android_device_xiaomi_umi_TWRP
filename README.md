# android_device_xiaomi_polaris
For building TWRP for Xiaomi Mi MIX 2S

TWRP device tree for Xiaomi MIX 2S

Kernel and all blobs are extracted from miui_MIMIX2S_8.10.11_13b40c2eee_9.0 firmware.

The Xiaomi Mi MIX 2S (codenamed _"polaris"_) are high-end smartphones from Xiaomi.

Xiaomi Mi MIX 2S was announced and released in April 2018.

## Device specifications

| Device       | Xiaomi Mi MIX 2S                                |
| -----------: | :---------------------------------------------- |
| SoC          | Qualcomm SDM845 Snapdragon 845                  |
| CPU          | 8x Qualcomm® Kryo™ 385 up to 2.8GHz             |
| GPU          | Adreno 630                                      |
| Memory       | 6GB / 8GB RAM (LPDDR4X)                         |
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
- Decryption of /data `fc1335025b030d58a82155c9ebd4cb98ccb56508`
- Screen brightness settings
- Now UI is very smooth `16d831bee5a660f5ac6da0d8fff2b3ec4697d663`
- Vibration on touch `c7c78d2fea4e9a53da09657ccb4155ec1344bd03`
- Correct screenshot color `8e4e8ec2f9890db53a6ecd1fa99fb73385271831`

Not Working:

- MTP FFS `d97d43360f6b9d3b9b6861b5566e85726a13109b`

## Compile

First checkout minimal twrp with omnirom tree:

```
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/polaris" name="TeamWin/android_device_xiaomi_polaris" remote="github" revision="android-9.0" />
```

Finally execute these:

```
. build/envsetup.sh
lunch omni_polaris-eng
mka recoveryimage ALLOW_MISSING_DEPENDENCIES=true # Only if you use minimal twrp tree.
```

To test it:

```
fastboot boot out/target/product/polaris/recovery.img
```
## Contributors

[Here](https://github.com/TeamWin/android_device_xiaomi_polaris/graphs/contributors)

## Thanks

- @travismills82 for his TWRP tree used as skeleton: [twrp_android_device_samsung_star2qltechn](https://github.com/travismills82/twrp_android_device_samsung_star2qltechn)

- @TeamWin for sagit TWRP tree used for partial decryption works: [android_device_xiaomi_sagit](https://github.com/TeamWin/android_device_xiaomi_sagit)

- @timesleader for dipper TWRP tree used for adb works:[android_device_xiaomi_dipper](https://github.com/timesleader/android_device_xiaomi_dipper)

- @wuxianlin for enchilada TWRP tree used for init.rc works:[android_device_oneplus_enchilada](https://github.com/TeamWin/android_device_oneplus_enchilada)
