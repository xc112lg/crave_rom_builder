#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/pull.sh pull.sh
chmod +x pull.sh
crave run --no-patch  -- "          #© crave.io Inc. 2017-2024
              #Thanks to UV n Team
        #no dual account just to build faster
              #respect the rule

rm -rf .repo/local_manifests 
git clone https://github.com/xc112lg/local_manifests -b main .repo/local_manifests
repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags
cd kernel/lge/msm8996;sleep 1 && git fetch https://github.com/xc112lg/msm8996_lge_kernel.git patch-1;sleep 1 && git cherry-pick 581d1240a1ac99ebbf172ec95b8d7f4f40ca4d21;cd ../../../;cd system/sepolicy;sleep 1 && git fetch https://github.com/xc112lg/android_system_sepolicy.git patch-1;sleep 1 && git cherry-pick 078ffd25a9c38a518df72391150dc132c9417bcf;cd ../../ 
source build/envsetup.sh
lunch lineage_h872-userdebug
m installclean
m bacon
"
. pull.sh
