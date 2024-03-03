#!/bin/bash

rm crave_rom_builder/*.zip crave_rom_builder/*.img
#crave pull out/target/product/*/recovery.img
crave pull out/target/product/*/*.zip out/target/product/*/recovery.img


source_folder="."
destination_folder="crave_rom_builder"

for file in $(find "$source_folder" -type f \( -name "*.zip" -o -name "*.img" -o -name "*.txt" -o -name "*.json" \) | grep -v "$destination_folder" | grep -v "/out/"); do
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

    if [ "${file##*.}" == "img" ]; then
        destination_path="$destination_folder/${base_name%.*}_$folder_name.img"
    fi

    echo "Moving: $file to $destination_path"
    mv "$file" "$destination_path"
done


export GH_TOKEN=$(cat ../gh_token.txt)
gh auth login --with-token $GH_TOKEN
cd crave_rom_builder
chmod u+x upload.sh
. upload.sh