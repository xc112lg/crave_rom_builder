#!/bin/bash
export GH_TOKEN=$(cat gh_token.txt)
#gh auth login --with-token $GH_TOKEN
cd /crave-devspaces
mkdir -p ArrowOS13-
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/run1.sh run1.sh
chmod +x run1.sh
cp -f crave_rom_builder/craverun.sh ArrowOS13-
./run1.sh
