#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/a.sh a.sh
chmod +x a.sh
basename "$(pwd)"> bp.txt
crave run --no-patch --clean -- "              #Im not a bot
          #Thanks to UV n Team
          #© crave.io Inc. 2017-2024
        #no dual account just to build faster
              #respect the rule
#say something nice, ice for sale
rm -rf .repo/local_manifests 
git clone https://github.com/jayz1212/local_manifests -b main .repo/local_manifests
repo sync -c -j16 --force-sync --no-clone-bundle --no-tags
source build/envsetup.sh
lunch lineage_h872-userdebug
m bacon
"
. a.sh
