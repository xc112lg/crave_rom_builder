#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/a.sh a.sh
chmod +x a.sh
basename "$(pwd)"> bp.txt
crave run --no-patch -- "              #Im not a bot
          #Thanks to UV n Team
          #© crave.io Inc. 2017-2024
        #no dual account just to build faster
              #respect the rule
#might take sometime to build mine sorry guys
mkdir -p cc &&rm -rf scripts prebuilts&& git clone https://github.com/xc112lg/scripts.git -b cd10 && repo init --depth 1 -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs  &&  chmod u+x scripts/sync.sh &&bash scripts/sync.sh
"
. a.sh
