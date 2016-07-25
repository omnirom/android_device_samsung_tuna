DEVICE_FOLDER := device/samsung/tuna

DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay-custom

# Fstab
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/rootdir/twrp.fstab:recovery/root/etc/twrp.fstab

PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.r_submix.default \
	audio.usb.default
