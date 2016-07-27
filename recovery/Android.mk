ifneq (,$(findstring $(TARGET_DEVICE),tuna toro toroplus maguro))

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# Edify extension functions for doing bootloader updates on Tuna devices.

LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := bootable/recovery system/vold external/openssl/include
LOCAL_SRC_FILES := recovery_updater.cpp bootloader.cpp update_cdma_modem.cpp

LOCAL_CFLAGS := -Wall -Werror

# should match TARGET_RECOVERY_UPDATER_LIBS set in BoardConfig.mk
LOCAL_MODULE := librecovery_updater_tuna

include $(BUILD_STATIC_LIBRARY)

# static smc_pa_ctrl for recovery
LOCAL_PATH := hardware/ti/omap4/security/smc_pa_ctrl
include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES:= \
	smc_pa_ctrl.c smc_pa_ctrl_linux.c

LOCAL_CFLAGS += -DLINUX
LOCAL_CFLAGS += -D__ANDROID32__

ifdef S_VERSION_BUILD
LOCAL_CFLAGS += -DS_VERSION_BUILD=$(S_VERSION_BUILD)
endif

LOCAL_CFLAGS += -I $(LOCAL_PATH)/../tf_sdk/include/

LOCAL_MODULE:= smc_pa_ctrl_recovery
LOCAL_MODULE_STEM := smc_pa_ctrl
LOCAL_MODULE_TAGS := optional
LOCAL_PACK_MODULE_RELOCATIONS := false
LOCAL_STATIC_LIBRARIES := libc libcutils liblog
LOCAL_FORCE_STATIC_EXECUTABLE := true

LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin

include $(BUILD_EXECUTABLE)

# static tf_daemon for recovery
LOCAL_PATH := hardware/ti/omap4/security/tf_daemon
include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := \
	delegation_client.c \
	delegation_client_extension.c \
	smc_properties.c \
	smc_properties_parser.c \
	lib_manifest2.c

LOCAL_CFLAGS += -DLINUX
LOCAL_CFLAGS += -D__ANDROID32__
LOCAL_CFLAGS += -DSUPPORT_DELEGATION_EXTENSION

ifdef S_VERSION_BUILD
LOCAL_CFLAGS += -DS_VERSION_BUILD=$(S_VERSION_BUILD)
endif

LOCAL_CFLAGS += -I $(LOCAL_PATH)/../tf_sdk/include/

LOCAL_MODULE:= tf_daemon_recovery
LOCAL_MODULE_STEM := tf_daemon
LOCAL_STATIC_LIBRARIES := libtee_client_api_driver libc libcutils liblog
LOCAL_MODULE_TAGS := optional
LOCAL_PACK_MODULE_RELOCATIONS := false
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin

include $(BUILD_EXECUTABLE)

endif
