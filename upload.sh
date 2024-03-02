#!/bin/bash


#BP=$(cat ../bp.txt)

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


# Get the longest zip file name
longest_zip_file=$(ls -1 *.zip 2>/dev/null | awk '{print length, $0}' | sort -n -r | head -n 1 | cut -d' ' -f2)

# If no zip files found, use the folder name
if [ -z "$longest_zip_file" ]; then
    longest_zip_file=$(basename "$(pwd)")
fi

# Check if the tag already exists
version=1
while gh release view "$longest_zip_file-ver$version" &> /dev/null; do
    version=$((version + 1))
done

# Ask for confirmation to delete the existing tag and releases
if gh release view "$longest_zip_file" &> /dev/null; then
    read -p "Tag $longest_zip_file already exists. Press Enter to delete it and its releases or Ctrl+C to cancel..."
    echo "Deleting existing tag and releases for $longest_zip_file..."
    gh release delete "$longest_zip_file" --yes
    git tag -d "$longest_zip_file"
    git push origin --delete "$longest_zip_file"
    echo "Existing tag and releases deleted."
fi

# Create the new tag and push it to GitHub
new_tag="$longest_zip_file-ver$version"
git tag -a "$new_tag" -m "Release $new_tag"
git push origin "$new_tag" --force


# Initialize an array to store the filenames
declare -a filenames

# Uncomment the following block if you want to upload all .zip and .img files in the current directory
filenames=(*.img *.zip)

# Otherwise, ask the user to input the filenames
# read -p "Enter the filenames (separated by spaces): " -a filenames

# Create the release on GitHub
if ! gh release create "$version" --title "Release $version" --notes "Release notes"; then
    echo "Error: Failed to create the release."
    exit 1
fi

# Upload the files to the release
for filename in "${filenames[@]}"; do
    gh release upload "$version" "$filename" --clobber
done

# Display success message
echo "Files uploaded successfully."