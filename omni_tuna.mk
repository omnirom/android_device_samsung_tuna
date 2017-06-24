# Copyright (C) 2017 OmniROM Project
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Exclude Live Wallpapers
TARGET_EXCLUDE_LIVEWALLPAPERS := true

# Use the AOSP browser
TARGET_USES_AOSP_BROWSER := true

# Bootanimation
TARGET_BOOTANIMATION_SIZE := 640x362

# Inherit from our omni product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# Pull in GSM-specific stuff such as APNs
$(call inherit-product, vendor/omni/config/gsm.mk)

# Inherit AOSP device configuration
$(call inherit-product, device/samsung/tuna/aosp_tuna.mk)

## Device identifier. This must come after all inclusions
PRODUCT_NAME := omni_tuna

# Device build info and fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=yakju \
    BUILD_FINGERPRINT="google/yakju/maguro:4.3/JWR66Y/776638:user/release-keys" \
    PRIVATE_BUILD_DESC="yakju-user 4.3 JWR66Y 776638 release-keys"
