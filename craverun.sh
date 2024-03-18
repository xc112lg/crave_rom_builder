#!/bin/bash
rm -rf crave_rom_builder
git clone https://$GH_TOKEN@github.com/xc112lg/crave_rom_builder.git
cp -f crave_rom_builder/pull.sh pull.sh
chmod +x pull.sh
crave run --no-patch  -- "          #© crave.io Inc. 2017-2024
              #Thanks to UV n Team
        #no dual account just to build faster
              #respect the rule

rm -rf .repo/local_manifests 
git clone https://github.com/xc112lg/local_manifests -b main .repo/local_manifests
output=\$(repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags 2>&1)
if echo "\$output" | grep -q "Failing repos:"; then
    while IFS= read -r line; do
        repo_info=\$(echo "\$line" | awk -F": " "{print \\$NF}")
        repo_path=\$(dirname "\$repo_info")
        repo_name=\$(basename "\$repo_info")
        rm -rf "\$repo_path/\$repo_name"
    done <<< "\$(echo "\$output" | awk "/Failing repos:/ {flag=1; next} /Repo command failed due to the following \`SyncError\` errors:/ {flag=0} flag")"
    repo sync -c -j\$(nproc --all) --force-sync --no-clone-bundle --no-tags
else
    echo "All repositories synchronized successfully."
fi
 
source build/envsetup.sh
lunch lineage_h872-userdebug
m installclean
m bacon
"
. pull.sh
