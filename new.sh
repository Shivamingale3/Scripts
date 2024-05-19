#!/bin/bash

get_rom(){
	echo "Available sources:"
	echo "1. Matrixx"
	echo "2. Awaken"
	echo "3. Cherish"
	echo "4. Derpfest"
	echo "5. New"
	read -r -p "Which ROM : 1 - 5 :" $rom
}


get_oth(){
	    echo "Cloning Kernel Source"
            git clone git clone https://github.com/raghavt20/kernel_sm8350.git -b thirteen kernel/motorola/tundra

            echo "Cloning Vendor Trees"
            git clone git@gitlab.com:shivamingale3/vendor-motorola-tundra.git vendor/motorola/tundra

            echo "Cloning QCOM"
            git clone git clone https://github.com/LineageOS/android_system_qcom.git system/qcom

            echo "Cloning Hardware"
            git clone git clone https://github.com/LineageOS/android_hardware_motorola.git hardware/motorola
}

get_trees(){
    
    if [$rom > 0 && $rom <6];    then
        if [ $rom == 1 ];   then
                directory = "matrixx"
                echo "ROM selected Project matrixx"
                cd ~/$directory
                echo "Cloning device Tree"
                git clone git@github.com:Shivamingale3/android_device_matrixx_tundra.git device/motorola/tundra
                get_oth

        elif [ $rom == 2 ]; then
                directory = "awaken"
                echo "ROM selected Awaken"
                cd ~/$directory
                git clone git@github.com:Shivamingale3/android_device_awaken_tundra.git device/motorola/tundra
                get_oth

        elif [ $rom == 3 ]; then
                directory = "cherish"
                echo "ROM selected Cherish"
                cd ~/$directory
                git clone git@github.com:Shivamingale3/android_device_cherish_tundra.git device/motorola/tundra
                get_oth

        elif [ $rom == 4 ]; then
                directory = "derp"
                echo "ROM selected Derpfest"
                cd ~/$directory
                git clone git@github.com:Shivamingale3/android_device_derpfest_tundra.git device/motorola/tundra
                get_oth

        elif [ $rom == 5 ]; then
                read -r -p "Enter rom folder name : " $directory
                echo "ROM selected "$directory
                cd ~/$directory
                git clone git@github.com:Shivamingale3/android_device_motorola_tundra.git -b qpr2 device/motorola/tundra
                get_oth

        fi

    else
	get_rom

    fi
}

get_rom
get_trees
