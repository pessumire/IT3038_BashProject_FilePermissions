#!/bin/bash
# File containing users and permissions
file="user_permissions.txt"
# Check for -h option
if [[ "$1" == "-h" ]]; then
    echo "Usage: ./file_permissions.sh"
    echo "This script reads a file with user permissions and prompts for updates."
    echo "File format: username: permissions"
    echo "Example:"
    echo "  user1: rwxr-x---"
    echo "  user2: rwxr--r--"
    exit 0
fi
# Function to validate permissions format
validate_permissions(){ 
    local perm=$1
    if [[ "$perm" =~ ^[rwx-]{9}$ ]]; then
        return 0  # Valid format
    else
        return 1  # Invalid format
    fi
}
# Loop through the file
while read line; do
    # Extract user and permissions
    user=$(echo $line | cut -d ":" -f 1)
    permissions=$(echo $line | cut -d ":" -f 2)

    # Show current permissions
    echo "Current permissions for $user: $permissions"

    # Ask for new permissions
     while true; do
        echo -n "Enter new permissions for $user: "
        read new_permissions

        # Validate the new permissions format
        if validate_permissions "$new_permissions"; then
            # Show updated permissions (no actual change to the file system)
            echo "Updated permissions for $user: $new_permissions"
            echo ""
            break  # Exit the loop if valid
        else
            echo "Invalid permissions format. Please use r, w, x, and - (e.g., rwxr-x---)."
          fi
        done
done < "$file"
