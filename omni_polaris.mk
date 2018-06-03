# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk) # If you are building for a phone

# Inherit from those products. Most specific first.
#$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)  # If you are building for a tablet

## Device identifier. This must come after all inclusions
PRODUCT_NAME := omni_polaris
PRODUCT_DEVICE := polaris
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := MI MIX 2S
PRODUCT_MANUFACTURER := Xiaomi

# If needed to overide these props
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT="Xiaomi/polaris/polaris:8.0.0/OPR1.170623.032/V9.5.12.0.ODGCNFA:user/release-keys" \
    PRIVATE_BUILD_DESC="polaris-user 8.0.0 OPR1.170623.032 V9.5.12.0.ODGCNFA release-keys"
    
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.treble.enabled=true \
    sys.usb.controller=a600000.dwc3 \
    persist.sys.usb.config=mtp \
    persist.service.adb.enable=1 \
    persist.service.debuggable=1 \
    sys.usb.rndis.func.name=gsi \
    sys.usb.rmnet.func.name=gsi

TARGET_VENDOR_PRODUCT_NAME := polaris
TARGET_VENDOR_DEVICE_NAME := polaris
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=polaris PRODUCT_NAME=polaris
