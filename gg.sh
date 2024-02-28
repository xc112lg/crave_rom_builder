#!/bin/bash

# Set the folder path to the current folder
folder_path="."

# Get a list of zip file names in the folder
zip_files=("$folder_path"/*.zip)

# Check if there are any zip files
if [ ${#zip_files[@]} -eq 0 ]; then
    echo "No zip files found in the current folder: $folder_path"
    exit 1
fi

# Extract common part of zip file names
common_part=$(printf "%s\n" "${zip_files[@]##*/}" | sed -e 'N;s/^\(.*\).*\n\1.*$/\1/;P;D')

# Check if there is more than one common part
if [ $(echo "$common_part" | wc -l) -gt 1 ]; then
    # Extract common part among the common parts
    final_common_part=$(printf "%s\n" "$common_part" | sed -e 'N;s/^\(.*\).*\n\1.*$/\1/;P;D')
    result="$final_common_part"
else
    result="$common_part"
fi

# Echo the result outside the if-else block
echo "Result: $result"


#!/bin/bash

# Set the folder path to the current folder
folder_path="."

# Get a list of zip file names in the folder
zip_files=("$folder_path"/*.zip)

# Check if there are any zip files
if [ ${#zip_files[@]} -eq 0 ]; then
    echo "No zip files found in the current folder: $folder_path"
    exit 1
fi

# Extract common part of zip file names starting from the last letter
reverse_common_part=$(printf "%s\n" "${zip_files[@]##*/}" | rev | sed -e 'N;s/^\(.*\).*\n\1.*$/\1/;P;D')

# Reverse the common part back to the original order
common_part1=$(echo "$reverse_common_part" | rev)

# Echo the common part starting from the last letter
echo "Common part of zip file names (starting from the last letter): $result$common_part1"
