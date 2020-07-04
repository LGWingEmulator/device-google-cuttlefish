#
# Copyright (C) 2019 The Android Open Source Project
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
#

#
# All components inherited here go to system image (same as GSI system)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system.mk)

PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

#
# All components inherited here go to system_ext image (same as GSI system_ext)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

#
# All components inherited here go to product image (same as GSI product)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

#
# All components inherited here go to vendor image
#
LOCAL_ENABLE_CODEC2 := true
LOCAL_CAMERAPROVIDER_PRODUCT_PACKAGE := \
    android.hardware.camera.provider@2.4-service_64
$(call inherit-product, device/google/cuttlefish/shared/phone/device_vendor.mk)

#
# Special settings for the target
#
$(call inherit-product, device/google/cuttlefish/vsoc_arm64/kernel.mk)

PRODUCT_NAME := aosp_cf_arm64_only_phone
PRODUCT_DEVICE := vsoc_arm64_only
PRODUCT_MODEL := Cuttlefish arm64 phone (64-bit only)