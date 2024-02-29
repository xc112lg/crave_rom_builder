#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/a.sh a.sh
chmod +x a.sh
basename "$(pwd)"> bp.txt
crave run --no-patch --clean -- "          #© crave.io Inc. 2017-2024
              #Thanks to UV n Team
        #no dual account just to build faster
              #respect the rule

rm -rf .repo&& mkdir -p los&& cd los && rm -rf lineage_build_leaos .repo/local_manifests&& git clone https://github.com/xc112lg/lineage_build_leaos -b lineage-18.1&&repo init  --depth 1 -u https://github.com/crdroidandroid/android.git -b 11.0 --git-lfs&& bash lineage_build_leaos/build.sh treble 64BVZ
"
. a.sh
