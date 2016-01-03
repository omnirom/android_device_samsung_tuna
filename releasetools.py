# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Emit commands needed for Prime during OTA installation
(installing the bootloader and radio images)."""

import common

def FullOTA_InstallEnd(info):
  TunaVariantSetup(info)

def TunaVariantSetup(info):
  # /system should be mounted when FullOTA_InstallEnd is fired off...
  # ...except for block-based packages. Blah! Problem is, I don't think
  # we can determine that from info :/ do it by hand.
  # thankfully, we can at least get the mount options.
  recovery_mount_options = info.info_dict.get("recovery_mount_options")

  # we need to make sure we're not already mounted however, for some reason.
  info.script.AppendExtra('ifelse(is_mounted("/system"), unmount("/system"));')
  info.script.Mount("/system", recovery_mount_options)

  info.script.AppendExtra('ui_print("device variant: " + tuna.get_variant());')

  info.script.AppendExtra('''if (tuna.get_variant() == "maguro") then (
  rename("/system/vendor/maguro/build.prop", "/system/vendor/build.prop");
  symlink("bcmdhd.maguro.cal", "/system/etc/wifi/bcmdhd.cal");
  symlink("../maguro/etc/sirfgps.conf", "/system/vendor/etc/sirfgps.conf");
  symlink("../maguro/firmware/bcm4330.hcd", "/system/vendor/firmware/bcm4330.hcd");
  symlink("../../maguro/lib/hw/gps.omap4.so", "/system/vendor/lib/hw/gps.omap4.so");
  symlink("../maguro/lib/libsec-ril.so", "/system/vendor/lib/libsec-ril.so");
  delete("/system/etc/permissions/android.hardware.telephony.cdma.xml");
  delete("/system/etc/wifi/bcmdhd.toro.cal");
  delete("/system/etc/wifi/bcmdhd.toroplus.cal");
  delete("/system/vendor/toro-common/etc/sirfgps.conf");
  delete("/system/vendor/toro-common/firmware/bcm4330.hcd");
  delete("/system/vendor/toro-common/lib/hw/gps.omap4.so");
  delete("/system/vendor/toro-common/lib/lib_gsd4t.so");
  delete("/system/vendor/toro/build.prop");
  delete("/system/vendor/toro/etc/apns-conf.xml");
  delete("/system/vendor/toro/lib/libims.so");
  delete("/system/vendor/toro/lib/libims_jni.so");
  delete("/system/vendor/toro/lib/libsec-ril_lte.so");
  delete("/system/vendor/toroplus/build.prop");
  delete("/system/vendor/toroplus/lib/libsec-ril_lte.so");
) endif;''')

  info.script.AppendExtra('''if (tuna.get_variant() == "toro") then (
  rename("/system/vendor/toro/build.prop", "/system/vendor/build.prop");
  rename("/system/vendor/toro/etc/apns-conf.xml", "/system/etc/apns-conf.xml");
  symlink("bcmdhd.toro.cal", "/system/etc/wifi/bcmdhd.cal");
  symlink("../toro/lib/libims.so", "/system/vendor/lib/libims.so");
  symlink("../toro/lib/libims_jni.so", "/system/vendor/lib/libims_jni.so");
  symlink("../toro/lib/libsec-ril_lte.so", "/system/vendor/lib/libsec-ril.so");
  delete("/system/etc/wifi/bcmdhd.toroplus.cal");
  delete("/system/vendor/toroplus/build.prop");
  delete("/system/vendor/toroplus/lib/libsec-ril_lte.so");
) endif;''')

  info.script.AppendExtra('''if (tuna.get_variant() == "toroplus") then (
  rename("/system/vendor/toroplus/build.prop", "/system/vendor/build.prop");
  symlink("bcmdhd.toroplus.cal", "/system/etc/wifi/bcmdhd.cal");
  symlink("../toroplus/lib/libsec-ril_lte.so", "/system/vendor/lib/libsec-ril.so");
  delete("/system/etc/wifi/bcmdhd.toro.cal");
  delete("/system/vendor/toro/build.prop");
  delete("/system/vendor/toro/etc/apns-conf.xml");
  delete("/system/vendor/toro/lib/libims.so");
  delete("/system/vendor/toro/lib/libims_jni.so");
  delete("/system/vendor/toro/lib/libsec-ril_lte.so");
) endif;''')

  info.script.AppendExtra('''if (tuna.get_variant() == "toro" || tuna.get_variant() == "toroplus") then (
  symlink("../toro-common/etc/sirfgps.conf", "/system/vendor/etc/sirfgps.conf");
  symlink("../toro-common/firmware/bcm4330.hcd", "/system/vendor/firmware/bcm4330.hcd");
  symlink("../../toro-common/lib/hw/gps.omap4.so", "/system/vendor/lib/hw/gps.omap4.so");
  symlink("../toro-common/lib/lib_gsd4t.so", "/system/vendor/lib/lib_gsd4t.so");
  delete("/system/etc/permissions/android.hardware.telephony.gsm.xml");
  delete("/system/etc/wifi/bcmdhd.maguro.cal");
  delete("/system/vendor/maguro/build.prop");
  delete("/system/vendor/maguro/etc/sirfgps.conf");
  delete("/system/vendor/maguro/firmware/bcm4330.hcd");
  delete("/system/vendor/maguro/lib/hw/gps.omap4.so");
  delete("/system/vendor/maguro/lib/libsec-ril.so");
) endif;''')

  info.script.AppendExtra('''if (tuna.get_variant() == "unknown") then (
  ui_print("Will attempt variant fixes on first boot; expect an extra reboot!")
) endif;''')
