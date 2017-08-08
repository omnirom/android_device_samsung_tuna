DEVICE_FOLDER := device/samsung/tuna

DEVICE_PACKAGE_OVERLAYS := $(DEVICE_FOLDER)/overlay-custom

# Recovery Ramdisk
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab

PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/rootdir/init.recovery.tuna.rc:root/init.recovery.tuna.rc

# OmniTorch
PRODUCT_PACKAGES += \
    OmniTorch
