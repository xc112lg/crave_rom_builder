#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/a.sh a.sh
chmod +x a.sh
basename "$(pwd)"> bp.txt
crave run --no-patch --clean -- "              #Im not a bot
          #only a test n thanks to UV n Team
          #© crave.io Inc. 2017-2024
        #no dual account just to build faster
              #respect the rule
test tin
"
. a.sh
