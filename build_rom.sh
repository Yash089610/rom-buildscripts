#!/bin/bash

# ==================TUNABLE==================
export BLOCK_BASED_OTA=false # Remove this string if you don't want to disable BLOCK Baseds SHIT!
CACHEDIRPATH=/ccache/android/ # Define your dir for ccache here
CCACHESIZE=10 # Define size of cache in GB, e.x CCACHESIZE=15 or CCACHESIZE=20 without "G" letter
IFARCHLINUX=true # Define true if your distro IS ArchLinux/ Define false if your distro NOT ArchLinux
CCACHEENABLE=true # Define true if u want to use ccache / Define false if u don't wand ccache
# export OUT_DIR_COMMON_BASE=/mnt/hdd/out # Define there or comment this var
# ===========================================

# ==================DEVICE===================
CURRENTDEVICE=taoshan # Define here build device. E.x CURRENTDEVICE=grouper or taoshan
# ===========================================

function buildfunct {
  croot
  case "$CURRENTDEVICE" in
    taoshan) breakfast taoshan
    ;;
    grouper) breakfast grouper
    ;;
    *) echo "Error, corrent typo"
  esac
  mka bacon
}

# PREPARE STAGE
. build/envsetup.sh

if [ $IFARCHLINUX == true ]; then
source venv/bin/activate
export PATH="/usr/lib/jvm/java-7-openjdk/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk
fi

if [ $CCACHEENABLE == true ]; then
export USE_CCACHE=1
export CCACHE_DIR="$CACHEDIRPATH".ccache
prebuilts/misc/linux-x86/ccache/ccache -M "$CCACHESIZE"G
fi

# BUILD STAGE
buildfunct
