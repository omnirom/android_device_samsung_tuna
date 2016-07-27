LOCAL_PATH := $(call my-dir)

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo ----- Made boot image -------- $@

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_kernel) \
		$(recovery_ramdisk)
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo ----- Made recovery image -------- $@

$(recovery_uncompressed_ramdisk): $(MINIGZIP) \
		$(TARGET_RECOVERY_ROOT_TIMESTAMP)
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/lib/modules
	cp -f $(TARGET_OUT)/system/bin/libtf_crypto_sst.so $(TARGET_RECOVERY_ROOT_OUT)/sbin/libtf_crypto_sst.so
	cp -f $(TARGET_OUT)/system/bin/smc_pa_ctrl $(TARGET_RECOVERY_ROOT_OUT)/sbin/smc_pa_ctrl
	cp -f $(TARGET_OUT)/system/bin/tf_daemon $(TARGET_RECOVERY_ROOT_OUT)/sbin/tf_daemon
	cp -f $(TARGET_OUT_SHARED_LIBRARIES)/hw/keystore.tuna.so $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/hw/keystore.tuna.so
	@echo ----- MMaking uncompressed recovery ramdisk -------- $@
	$(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $@

