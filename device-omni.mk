DEVICE_FOLDER := device/samsung/tuna

# TWRP Fstab
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/recovery/root/etc/twrp.fstab:recovery/root/etc/twrp.fstab
