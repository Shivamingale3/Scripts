#!/bin/bash

git clone https://github.com/Shivamingale3/device_motorola_tundra.git -b rising device/motorola/tundra


git clone https://gitlab.com/shivamingale3/vendor-motorola-tundra.git vendor/motorola/tundra


git clone https://github.com/Shivamingale3/kernel_motorola_tundra.git -b main kernel/motorola/tundra


git clone https://github.com/LineageOS/android_system_qcom.git system/qcom


git clone https://github.com/LineageOS/android_hardware_motorola.git hardware/motorola

####################################################################################################

. build/envsetup.sh

lunch rising_tundra-user

m updatepackage

####################################################################################################

