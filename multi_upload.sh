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


# Check if the tag already exists
if gh release view "$common_part" &> /dev/null; then
    # Tag exists, ask for confirmation to delete the tag and releases
    read -p "Tag $common_part already exists. Press Enter to delete it and its releases or Ctrl+C to cancel..."
    echo "Deleting existing tag and releases for $common_part..."
    gh release delete "$common_part" --yes
    git tag -d "$common_part"
    git push origin --delete "$common_part"
    echo "Existing tag and releases deleted."
fi

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
if ! gh release create "$common_part" --title "Release $common_part" --notes "Release notes"; then
    echo "Error: Failed to create the release."
    exit 1
fi

# Upload the files to the release
for filename in "${filenames[@]}"; do
    gh release upload "$common_part" "$filename" --clobber
done

# Display success message
echo "Files uploaded successfully."
