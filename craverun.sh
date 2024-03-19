#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/pull.sh pull.sh
chmod +x pull.sh
crave run --no-patch --clean -- "          #© crave.io Inc. 2017-2024
              #Thanks to UV n Team
        #no dual account just to build faster
              #respect the rule

rm -rf .repo/local_manifests 
git clone https://github.com/xc112lg/local_manifests -b a5 .repo/local_manifests
/opt/crave/resync.sh
 
source build/envsetup.sh
lunch lineage_a5y17lte-userdebug
m installclean
m bacon
"
. pull.sh
