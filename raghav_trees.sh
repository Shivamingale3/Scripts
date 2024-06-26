#!/bin/bash

echo "---------------------------------------------------Cloning Vendor Tree-----------------------------------------------------"

git clone https://gitlab.com/raghavt20/proprietary_vendor_motorola_tundra vendor/motorola/tundra

echo "---------------------------------------------------Cloning Kernel Tree-----------------------------------------------------"

git clone https://github.com/raghavt20/kernel_sm8350.git kernel/motorola/tundra

echo "---------------------------------------------------Cloning qcom------------------------------------------------------------"

git clone https://github.com/LineageOS/android_system_qcom.git system/qcom 

echo "---------------------------------------------------Cloning hardware--------------------------------------------------------"

git clone https://github.com/LineageOS/android_hardware_motorola.git hardware/motorola
