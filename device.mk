#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8450-common
TARGET_HAS_UDFPS := true
$(call inherit-product, device/xiaomi/sm8450-common/common.mk)

# Audio
PRODUCT_PACKAGES += \
    firmware_aw_cali.bin_symlink

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/mixer_paths_waipio_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cape/mixer_paths_waipio_mtp.xml \
    $(LOCAL_PATH)/audio/resourcemanager_waipio_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cape/resourcemanager_waipio_mtp.xml \
    $(LOCAL_PATH)/audio/usecaseKvManager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usecaseKvManager.xml

# Light
$(call soong_config_set,xiaomi_sm8450_sensor_notifier,extension_lib,//device/xiaomi/mayfly:libsensor-notifier-ext-light)

# Logging
SPAMMY_LOG_TAGS := \
    MiStcImpl \
    SDM \
    SDM-histogram \
    SRE \
    WifiHAL \
    cnss-daemon \
    libcitsensorservice@2.0-impl \
    libsensor-displayalgo \
    libsensor-parseRGB \
    libsensor-ssccalapi \
    sensors \
    vendor.qti.hardware.display.composer-service \
    vendor.xiaomi.sensor.citsensorservice@2.0-service

ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_VENDOR_PROPERTIES += \
    $(foreach tag,$(SPAMMY_LOG_TAGS),log.tag.$(tag)=E)
endif

# Overlay
PRODUCT_PACKAGES += \
    ApertureResMayfly \
    FrameworksResMayfly \
    LineageResMayfly \
    NfcResMayfly \
    SettingsProviderResMayfly \
    SystemUIResMayfly \
    WifiResMayfly

# PowerHAL
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.powershare-service.default

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Vibrator
$(call soong_config_set,qti_vibrator,effect_lib,libqtivibratoreffect.xiaomi)
$(call soong_config_set_bool,qti_vibrator,use_effect_stream,true)

# Call the proprietary setup
$(call inherit-product, vendor/xiaomi/mayfly/mayfly-vendor.mk)
