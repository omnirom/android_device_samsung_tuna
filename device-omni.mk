DEVICE_FOLDER := device/samsung/tuna

# TWRP Fstab
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/rootdir/twrp.fstab:recovery/root/etc/twrp.fstab
