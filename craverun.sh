#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/pull.sh pull.sh
chmod +x pull.sh
crave run --no-patch  -- "          #© crave.io Inc. 2017-2024
              #Thanks to UV n Team
        #no dual account just to build faster
              #respect the rule
mkdir justdoingtesting; ls
"
. pull.sh
