DEVICE_FOLDER := device/samsung/tuna

DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay-custom

# Fstab
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/rootdir/twrp.fstab:recovery/root/etc/twrp.fstab
