# android_device_xiaomi_umi
For building TWRP for Xiaomi Mi 10

TWRP device tree for Xiaomi Mi 10

## Features

**Untested!**

Mi 10 is using Dynamic Partition! We need update from TWRP.

## Compile

First checkout minimal twrp with omnirom tree:

```
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/umi" name="simonsmh/android_device_xiaomi_umi" remote="github" revision="android-9.0" />
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
