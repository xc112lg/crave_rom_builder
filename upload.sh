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


# Get a list of zip files in the current folder
zip_files=$(ls *.zip 2>/dev/null)

# Check if there are any zip files
if [ -n "$zip_files" ]; then
    # Find the zip file with the longest base name (excluding the ".zip" extension)
    common_part=""
    max_length=0
    
    for zip_file in $zip_files; do
        base_name=$(basename "$zip_file" .zip)
        length=${#base_name}
        
        if [ $length -gt $max_length ]; then
            max_length=$length
            common_part=$base_name
        fi
    done

    echo "Longest Base Named Zip File: ${common_part}"
else
    echo "No zip files found in the current folder."
fi


echo "Common part of filenames: $common_part"

# Set the version with default if not provided
version1=${custom_version:-"$common_part"}

# Use the version for further processing
echo "Selected version: $common_part"


# Set the version with default if not provided
version=${custom_version:-"$common_part"}


last_version=$(gh release list --limit 1 | awk '{print $1}')

# Extract the numeric part of the last version
last_number=$(echo "$last_version" | awk -F'-' '{print $NF}')

# If there is no previous version, set the counter to 1; otherwise, increment the counter
counter=$((last_number + 1))
# Check if the tag already exists
while gh release view "$common_part" &> /dev/null; do
    # Tag exists, increment the version number
    echo "Tag $common_part already exists. Incrementing version number..."
    version="$common_part-ver$((counter++))"
done



# Create the new tag and push it to GitHub
git tag -a "$common_part" -m "Release $common_part"
git push origin "$common_part" --force

# Initialize an array to store the filenames
declare -a filenames

# Uncomment the following block if you want to upload all .zip and .img files in the current directory
filenames=(*.img *.zip)

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