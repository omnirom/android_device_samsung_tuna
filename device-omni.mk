DEVICE_FOLDER := device/samsung/tuna

DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay-custom

# TWRP Fstab
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/recovery/root/etc/twrp.fstab:recovery/root/etc/twrp.fstab
