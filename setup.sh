#!/bin/bash
echo "==========================================================================================================================="
echo "=================================================Setting Up Environment===================================================="
echo "==========================================================================================================================="

#echo "What are we building today?"

#echo "1. Project-Matrixx"

#echo "2. Superior-Extended"

#echo "3. AwakenOS"

#echo "4. DerpfestOS"

#read -p "Target : " target


sudo apt install neofetch -y > /dev/null

neofetch

echo "        By : Shivam Ingale"

sudo apt update && sudo apt upgrade -y

#Install UNZIP
echo "==========================================================================================================================="
echo "====================================================Installing UNZIP======================================================="
echo "==========================================================================================================================="

sudo apt update 

sudo apt install unzip -y

# Setting up Platform tools
echo "==========================================================================================================================="
echo "=================================================Getting Platform-tools===================================================="
echo "==========================================================================================================================="

cd ~/

wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip


echo "==========================================================================================================================="
echo "===============================================Extracting Platform-tools==================================================="
echo "==========================================================================================================================="

unzip platform-tools-latest-linux.zip -d ~

echo "==========================================================================================================================="
echo "==============================================Adding Platform-tools to path================================================"
echo "==========================================================================================================================="

cd ~/

echo '# add Android SDK platform tools to path
if [ -d "$HOME/platform-tools" ] ; then
    PATH="$HOME/platform-tools:$PATH"
fi' >> ~/.profile

source ~/.profile

echo "==========================================================================================================================="
echo "=================================================Installing Required Packages=============================================="
echo "==========================================================================================================================="

# Script to setup an AOSP Build environment on Ubuntu

LATEST_MAKE_VERSION="4.3"
UBUNTU_16_PACKAGES="libesd0-dev"
UBUNTU_20_PACKAGES="libncurses5 curl python-is-python3"
DEBIAN_10_PACKAGES="libncurses5"
DEBIAN_11_PACKAGES="libncurses5"
PACKAGES=""

sudo apt install software-properties-common -y
sudo apt update

# Install lsb-core packages
sudo apt install lsb-core -y

LSB_RELEASE="$(lsb_release -d | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')"

if [[ ${LSB_RELEASE} =~ "Mint 18" || ${LSB_RELEASE} =~ "Ubuntu 16" ]]; then
    PACKAGES="${UBUNTU_16_PACKAGES}"
elif [[ ${LSB_RELEASE} =~ "Ubuntu 20" || ${LSB_RELEASE} =~ "Ubuntu 21" || ${LSB_RELEASE} =~ "Ubuntu 22" || ${LSB_RELEASE} =~ 'Pop!_OS 2' ]]; then
    PACKAGES="${UBUNTU_20_PACKAGES}"
elif [[ ${LSB_RELEASE} =~ "Debian GNU/Linux 10" ]]; then
    PACKAGES="${DEBIAN_10_PACKAGES}"
elif [[ ${LSB_RELEASE} =~ "Debian GNU/Linux 11" ]]; then
    PACKAGES="${DEBIAN_11_PACKAGES}"
fi

sudo DEBIAN_FRONTEND=noninteractive \
    apt install \
    adb autoconf automake axel bc bison build-essential \
    ccache clang cmake curl expat fastboot flex g++ \
    g++-multilib gawk gcc gcc-multilib git git-lfs gnupg gperf \
    htop imagemagick lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev \
    libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev \
    libsdl1.2-dev libssl-dev libtool libxml2 libxml2-utils '^lzma.*' lzop \
    maven ncftp ncurses-dev patch patchelf pkg-config pngcrush \
    pngquant python2.7 python-all-dev re2c schedtool squashfs-tools subversion \
    texinfo unzip w3m xsltproc zip zlib1g-dev lzip \
    libxml-simple-perl libswitch-perl apt-utils rsync \
    ${PACKAGES} -y

echo -e "Installing GitHub CLI"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh

echo -e "Setting up udev rules for adb!"
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
sudo systemctl restart udev

if [[ "$(command -v make)" ]]; then
    makeversion="$(make -v | head -1 | awk '{print $3}')"
    if [[ ${makeversion} != "${LATEST_MAKE_VERSION}" ]]; then
        echo "Installing make ${LATEST_MAKE_VERSION} instead of ${makeversion}"
        bash "$(dirname "$0")"/make.sh "${LATEST_MAKE_VERSION}"
    fi
fi

sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev -y


echo "Installing repo"
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
sudo chmod a+rx /usr/local/bin/repo

echo "==========================================================================================================================="
echo "====================================================Installing repo========================================================"
echo "==========================================================================================================================="

mkdir -p ~/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

chmod a+x ~/bin/repo

echo "==========================================================================================================================="
echo "======================================================Setting Git=========================================================="
echo "==========================================================================================================================="

git config --global user.email "shivamingale3@gmail.com"
echo "Email set to : shivamingale3@gmail.com"

git config --global user.name "Shivamingale3"
echo "Name set to : Shivamingale3"

echo "==========================================================================================================================="
echo "=====================================================Making swap file======================================================"
echo "==========================================================================================================================="

cd ~

sudo swapon --show

free -h

df -h

sudo fallocate -l 50G /swapfile

ls -lh /swapfile

sudo chmod 600 /swapfile

ls -lh /swapfile

sudo mkswap /swapfile

sudo swapon /swapfile

sudo cp /etc/fstab /etc/fstab.bak

echo "==========================================================================================================================="
echo "=====================================================Enabling CCACHE 50G==================================================="
echo "==========================================================================================================================="
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
ccache -o compression=true

echo "==========================================================================================================================="
echo "=============================================================Done=========================================================="
echo "==========================================================================================================================="
swapon --show
echo "==========================================================================================================================="

# echo "==========================================================================================================================="
# echo "===================================================Getting ROM Source======================================================"
# echo "==========================================================================================================================="

# cd ~
# #For Project-Matrixx
# if [ $target -eq 1 ]; then
#     mkdir matrixx
#     cd matrixx
#     repo init -u https://github.com/ProjectMatrixx/android.git -b 14.0 --git-lfs 
#     repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
#     #Kernel Tree 
#     git clone https://github.com/raghavt20/kernel_sm8350.git -b thirteen kernel/motorola/tundra 
    
#     #Device Tree
#     git clone https://github.com/Shivamingale3/device_matrixx_tundra.git device/motorola/tundra  
    
#     #Vendor Tree
#     git clone https://github.com/Shivamingale3/vendor_motorola_tundra.git vendor/motorola/tundra
    
#     #QCOM Stuff
#     git clone https://github.com/LineageOS/android_system_qcom.git system/qcom 
    
#     # Motorola Stuff
#     git clone https://github.com/LineageOS/android_hardware_motorola.git hardware/motorola

# elif [ $target -eq 2 ]; then
#     mkdir superior
#     cd superior
#     repo init -u https://github.com/SuperiorExtended/manifest -b UDC --git-lfs
#     repo sync --force-sync
#     #Kernel Tree 
#     git clone https://github.com/raghavt20/kernel_sm8350.git -b thirteen kernel/motorola/tundra 
    
#     #Device Tree
#     git clone https://github.com/Shivamingale3/device_superior_tundra.git device/motorola/tundra  
    
#     #Vendor Tree
#     git clone https://github.com/Shivamingale3/vendor_motorola_tundra.git vendor/motorola/tundra
    
#     #QCOM Stuff
#     git clone https://github.com/LineageOS/android_system_qcom.git system/qcom 
    
#     # Motorola Stuff
#     git clone https://github.com/LineageOS/android_hardware_motorola.git hardware/motorola



# elif [ $target -eq 3 ]; then
#     mkdir awaken
#     cd awaken
#     repo init -u https://github.com/Project-Awaken/android_manifest -b ursa
#     repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
#     #Kernel Tree 
#     git clone https://github.com/raghavt20/kernel_sm8350.git -b thirteen kernel/motorola/tundra 
    
#     #Device Tree
#     git clone https://github.com/Shivamingale3/device_awaken_tundra.git device/motorola/tundra  
    
#     #Vendor Tree
#     git clone https://github.com/Shivamingale3/vendor_motorola_tundra.git vendor/motorola/tundra
    
#     #QCOM Stuff
#     git clone https://github.com/LineageOS/android_system_qcom.git system/qcom 
    
#     # Motorola Stuff
#     git clone https://github.com/LineageOS/android_hardware_motorola.git hardware/motorola

# elif [ $target -eq 4 ]; then
#     mkdir derpfest
#     cd derpfest
#     repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14
#     repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
#      #Kernel Tree 
#     git clone https://github.com/raghavt20/kernel_sm8350.git -b thirteen kernel/motorola/tundra 
    
#     #Device Tree
#     git clone https://github.com/Shivamingale3/device_derpfest_tundra.git device/motorola/tundra  
    
#     #Vendor Tree
#     git clone https://github.com/Shivamingale3/vendor_motorola_tundra.git vendor/motorola/tundra
    
#     #QCOM Stuff
#     git clone https://github.com/LineageOS/android_system_qcom.git system/qcom 
    
#     # Motorola Stuff
#     git clone https://github.com/LineageOS/android_hardware_motorola.git hardware/motorola


# fi
