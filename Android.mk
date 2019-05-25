LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),cepheus)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
