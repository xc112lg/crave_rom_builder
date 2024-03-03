#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/pull.sh pull.sh
chmod +x pull.sh
crave run --no-patch --clean -- "          #© crave.io Inc. 2017-2024
              #Thanks to UV n Team
        #no dual account just to build faster
              #respect the rule
repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
rm -rf .repo/local_manifests prebuilts
git clone https://github.com/jayz1212/local_manifests -b main .repo/local_manifests
repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags
rf device/lge/msm8996-common;git clone https://github.com/xc112lg/android_device_lge_msm8996-common -b cd10 device/lge/msm8996-common 
source build/envsetup.sh
m installclean
lunch lineage_h872-userdebug
m bacon
"
. pull.sh
