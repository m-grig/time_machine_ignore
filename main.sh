#!/bin/bash

# Args:
##########################################
# Directory where your development projects live:
DEVELOPMENT_DIRECTORY=~/dev
# Define an array of directory names to search for and exclude:
DIR_NAMES=("node_modules" ".git")
##########################################



# Construct the find command dynamically
CMD="find $(pwd) -type d -maxdepth 7"

# Add each name condition
for DIR in "${DIR_NAMES[@]}"; do
    CMD+=" -o -name \"$DIR\""
done

# Replace the first '-o' with '\(' to properly group conditions
CMD=$(echo "$CMD" | sed 's/-o /\\( /' | sed 's/$/ \\)/')

# Pipe result into tmutil to exclude from time machine backups
CMD+=" | xargs -n 1 tmutil addexclusion"

# Change directory to the development directory
cd $DEVELOPMENT_DIRECTORY

# Execute the command
eval "$CMD"
