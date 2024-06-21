#!/bin/bash

echo "---------------------------------------------------Cloning Vendor Tree-----------------------------------------------------"

git clone git@gitlab.com:shivamingale3/vendor-motorola-tundra.git vendor/motorola/tundra

echo "---------------------------------------------------Cloning Kernel Tree-----------------------------------------------------"

git clone git@github.com:Shivamingale3/kernel_motorola_tundra.git kernel/motorola/tundra

echo "---------------------------------------------------Cloning qcom------------------------------------------------------------"

git clone https://github.com/LineageOS/android_system_qcom.git system/qcom

echo "---------------------------------------------------Cloning hardware--------------------------------------------------------"

git clone https://github.com/LineageOS/android_hardware_motorola.git hardware/motorola
