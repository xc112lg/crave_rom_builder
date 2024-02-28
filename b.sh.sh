#!/bin/bash

rm -rf h870/* h872/* us997/*
rm crave/*.zip
crave pull out/target/product/*/*.zip out/target/product/*/recovery.img out/target/product/*/*.json out/target/product/*/changelog_*.txt
mv h870/recovery.img h870/recoveryh870.img
mv h872/recovery.img h872/recoveryh872.img
mv us997/recovery.img us997/recoveryus997.img
mv h870/* h872/* us997/* ./crave
export GH_TOKEN=$(cat ../gh_token.txt)
gh auth login --with-token $GH_TOKEN
cd crave
chmod u+x m.sh
. m.sh