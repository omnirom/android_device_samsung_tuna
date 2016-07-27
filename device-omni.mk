DEVICE_FOLDER := device/samsung/tuna

DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay-custom

# Fstab
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/rootdir/twrp.fstab:recovery/root/etc/twrp.fstab \
	$(DEVICE_FOLDER)/recovery/root/vendor/etc/smc_normal_world_android_cfg.ini:/recovery/root/vendor/etc/smc_normal_world_android_cfg.ini \
	$(DEVICE_FOLDER)/recovery/root/vendor/firmware/smc_pa_wvdrm.ift:/recovery/root/vendor/firmware/smc_pa_wvdrm.ift

PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.r_submix.default \
	audio.usb.default
