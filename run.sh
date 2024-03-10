#!/bin/bash
export GH_TOKEN=$(cat gh_token.txt)
#gh auth login --with-token $GH_TOKEN
#gh auth status
mkdir -p ArrowOS13
bp=$(cat bp.txt)
cp -f crave_rom_builder/run1.sh run1.sh
chmod +x run1.sh
cp -f crave_rom_builder/craverun.sh ArrowOS13
./run1.sh
