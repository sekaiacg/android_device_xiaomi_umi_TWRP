LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
    LOCAL_MODULE := magisk_prebuilt
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
    CUSTOMZIP_PATH := $(TARGET_RECOVERY_ROOT_OUT)/customzip
    LOCAL_POST_INSTALL_CMD := \
        $(LOCAL_PATH)/magisk_prebuilt.sh $(CUSTOMZIP_PATH);
include $(BUILD_PHONY_PACKAGE)
