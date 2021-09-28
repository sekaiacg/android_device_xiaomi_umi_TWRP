#device(model): cmi(10pro) umi(10)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.device=$(PRODUCT_RELEASE_NAME) \
    ro.product.odm.device=$(PRODUCT_RELEASE_NAME) \
    ro.product.system.device=$(PRODUCT_RELEASE_NAME) \
    ro.product.vendor.device=$(PRODUCT_RELEASE_NAME) \
    ro.build.product=$(PRODUCT_RELEASE_NAME) \
    ro.product.name=$(PRODUCT_RELEASE_NAME) \
    ro.product.odm.name=$(PRODUCT_RELEASE_NAME) \
    ro.product.product.device=$(PRODUCT_RELEASE_NAME) \
    ro.product.product.name=$(PRODUCT_RELEASE_NAME) \
    ro.product.system.name=$(PRODUCT_RELEASE_NAME) \
    ro.product.system_ext.device=$(PRODUCT_RELEASE_NAME) \
    ro.product.system_ext.name=$(PRODUCT_RELEASE_NAME) \
    ro.product.vendor.name=$(PRODUCT_RELEASE_NAME)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.model=$(PRODUCT_MODEL) \
    ro.product.odm.model=$(PRODUCT_MODEL) \
    ro.product.system.model=$(PRODUCT_MODEL) \
    ro.product.vendor.model=$(PRODUCT_MODEL) \
    ro.product.product.model=$(PRODUCT_MODEL) \
    ro.product.system_ext.model=$(PRODUCT_MODEL)
