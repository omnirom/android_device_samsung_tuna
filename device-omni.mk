DEVICE_FOLDER := device/samsung/tuna

DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay-custom

# TWRP ramdisk
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/recovery/root/init.recovery.tuna.rc:recovery/root/init.recovery.tuna.rc \
	$(DEVICE_FOLDER)/recovery/root/etc/twrp.fstab:recovery/root/etc/twrp.fstab \
	$(DEVICE_FOLDER)/recovery/root/vendor/etc/smc_normal_world_android_cfg.ini:recovery/root/vendor/etc/smc_normal_world_android_cfg.ini \
	$(DEVICE_FOLDER)/recovery/root/vendor/firmware/smc_pa_wvdrm.ift:recovery/root/vendor/firmware/smc_pa_wvdrm.ift

# dummy compiling Android 7.1 TWRP inside Omni6 source
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/recovery/root/res/dummy:recovery/root/res/dummy