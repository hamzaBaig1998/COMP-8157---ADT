#!/bin/bash

# Check if no input parameters are provided
if [ $# -eq 0 ]; then
  echo "Error: No input files specified"
  exit 1
fi

# Initialize variables
output_file="output.txt"
content=""

# Concatenate the contents of all text files in the serial order
until [ -z "$1" ]; do
  # Check if the file exists and is a .txt file
  if [ ! -f "$1" ] || [ "${1: -4}" != ".txt" ]; then
    echo "Error: $1 is not a valid text file"
    exit 1
  fi
  # Concatenate the contents of the file
  content+=$(cat "$1")
  shift
done

# Save the final result to output.txt
echo "$content" > "$output_file"
echo "Concatenated contents of input files saved to $output_file"