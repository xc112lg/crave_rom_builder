#!/bin/bash

# Check if gh command-line tool is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI 'gh' not found. Downloading and installing..."
    wget https://github.com/cli/cli/releases/download/v2.40.1/gh_2.40.1_linux_amd64.tar.gz
    tar -xvf gh_2.40.1_linux_amd64.tar.gz
    sudo mv gh_*_linux_amd64/bin/gh /usr/local/bin/
    echo "GitHub CLI 'gh' installed successfully."
else
    echo "GitHub CLI 'gh' is already installed."
fi

# Check if user is already authenticated
if ! gh auth status &> /dev/null; then
    # User not authenticated, perform login
    gh auth login --with-token $GH_TOKEN
else
    echo "Already authenticated with GitHub."
fi

# Determine the tag name
if [ "$(ls -1 *.zip 2>/dev/null | wc -l)" -gt 0 ]; then
    # Get the longest zip filename
    longest_zip=$(ls -1 *.zip | awk '{print length, $0}' | sort -n -r | head -n 1 | cut -d' ' -f2)
    common_part=$(basename -s .zip "$longest_zip")
else
    # If no zip files, use the current folder name as the tag
    common_part=$(basename "$(pwd)")
fi

# If the tag already exists, increment the tag with a decimal number
count=1
while gh release view "$common_part" &> /dev/null; do
    common_part="${common_part}_$(echo "scale=1; $count/10" | bc | sed 's/\.//')"
    count=$((count+1))
done

# Create the new tag and push it to GitHub
git tag -a "$common_part" -m "Release $common_part"
git push origin "$common_part" --force

# Initialize an array to store the filenames
declare -a filenames

# Uncomment the following block if you want to upload all .zip and .img files in the current directory
filenames=(*.zip *.img *.txt *.json)

# Otherwise, ask the user to input the filenames
# read -p "Enter the filenames (separated by spaces): " -a filenames

# Create the release on GitHub
if ! gh release create "$common_part" --title "Release $common_part" --notes "Release notes" 2>&1; then
    echo "Error: Failed to create the release."
    exit 1
fi

# Upload the files to the release
for filename in "${filenames[@]}"; do
    gh release upload "$common_part" "$filename" --clobber
done

# Display success message
echo "Files uploaded successfully."
