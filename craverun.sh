#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/pull.sh pull.sh
chmod +x pull.sh
trap crave stop --all SIGTERM
crave run --no-patch  -- "          #© crave.io Inc. 2017-2024
              #Thanks to UV n Team
        #no dual account just to build faster
              #respect the rule
# 

rm -rf .repo/local_manifests 
git clone https://github.com/jayz1212/local_manifests -b main .repo/local_manifests
repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags
source build/envsetup.sh
m installclean
lunch -userdebug
m bacon
"
. pull.sh
