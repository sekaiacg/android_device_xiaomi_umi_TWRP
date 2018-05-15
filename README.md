# android_device_xiaomi_polaris

TWRP device tree for Xiaomi MIX 2S

## Features

Works:

- ADB
- Decryption of /data

Not works:

- Screen flashes/flickering
- UI respond slowly

## Compile

First checkout full omnirom tree:

```
repo init -u git://github.com/omnirom/android.git -b android-8.1
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/qcom/common/cryptfs_hw" name="notsyncing/android_vendor_qcom_opensource_cryptfs_hw" remote="github" revision="android-8.1" />

<project path="device/xiaomi/polaris" name="notsyncing/android_device_xiaomi_polaris" remote="github" revision="android-8.1" />
```

Finally execute these:

```
. build/envsetup.sh
lunch omni_polaris-eng 
make adbd recoveryimage -j8
```

To test it:

```
fastboot boot out/target/product/polaris/recovery.img
```

## Troubleshooting

### When compile: "flex-2.5.39: loadlocale.c:130:_nl_intern_locale_data: ?? 'cnt < (sizeof (_nl_value_type_LC_TIME) / sizeof (_nl_value_type_LC_TIME[0]))' ???"

Execute this:

```
export LC_ALL=C
```

Then recompile.

### Wrong theme color in TWRP (orange/yellow color instead of blue)

Replace bootable/recovery/minuitwrp/graphics_drm.cpp, line 162-164:

```cpp
format = DRM_FORMAT_RGB565;
base_format = GGL_PIXEL_FORMAT_BGRA_8888;
printf("setting DRM_FORMAT_RGB565 and GGL_PIXEL_FORMAT_RGB_565\n");
```

to

```cpp
format = DRM_FORMAT_XBGR8888;
base_format = GGL_PIXEL_FORMAT_RGBX_8888;
printf("setting DRM_FORMAT_XBGR8888 and GGL_PIXEL_FORMAT_RGBX_8888\n");
```

## Thanks

- @travismills82 for his TWRP tree used as skeleton: [twrp_android_device_samsung_star2qltechn](https://github.com/travismills82/twrp_android_device_samsung_star2qltechn)

- 宅科技_zecoki (or wx_pmZ7777t in the inner link), used for ADB works: [	
[Recovery] 小米 MIX2s TWRP recovery下载](https://blog.csdn.net/u010880477/article/details/80285813)