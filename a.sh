#!/bin/bash

rm crave/*.zip crave/*.txt crave/*.json crave/*.img
# crave pull out/target/product/*/recovery.zip
crave pull out/target/product/*/*.zip out/target/product/*/recovery.img out/target/product/*/*.json out/target/product/*/changelog_*.txt


source_folder="."
destination_folder="crave"

for file in $(find "$source_folder" -type f \( -name "*.zip" -o -name "*.img" -o -name "*.txt" -o -name "*.json" \) | grep -v "$destination_folder"); do
    [ -e "$file" ] || continue

    base_name=$(basename "$file")
    folder_name=$(basename "$(dirname "$file")")

    # Replace underscores with hyphens in base_name
    base_name=$(echo "$base_name" | tr '_' '-')

    destination_path="$destination_folder/$base_name"

    if [ -e "$destination_path" ]; then
        counter=1
        while [ -e "$destination_path" ]; do
            new_name="${base_name%.*}_${folder_name}_$counter.${base_name##*.}"
            destination_path="$destination_folder/$new_name"
            counter=$((counter + 1))
        done
    fi

    echo "Moving: $file to $destination_path"
    mv "$file" "$destination_path"
done

export GH_TOKEN=$(cat ../gh_token.txt)
gh auth login --with-token $GH_TOKEN
cd crave
chmod u+x m.sh
. m.sh