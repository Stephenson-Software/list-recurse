#!/bin/bash
# Recursively list all files in a directory.

# ANSI color codes
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# check if PROJECT_ROOT_DIR is set
if [ -z "$PROJECT_ROOT_DIR" ]; then
    echo "PROJECT_ROOT_DIR is not set. Please set PROJECT_ROOT_DIR to the root directory of the project."
    exit 1
fi

# check if argument is supplied
if [ -z "$1" ]; then
    echo "No argument supplied. Usage: list-recurse.sh <directory>"
    exit 1
fi

# set indent level
if [ -z "$2" ]; then
    indent_level=0
else
    indent_level=$2
fi

# for each file in directory
for f in $1/*; do

    # build indentation string
    indent_string=""
    for ((i=0; i<indent_level; i++)); do
        indent_string="$indent_string  "
    done
    
    if [ -d "$f" ]; then
        # print directory name
        echo -e "${YELLOW}$indent_string$(basename "$f")"

        # increment indent level
        indent_level=$((indent_level+1))

        # recursively list files in directory
        $PROJECT_ROOT_DIR/list-recurse.sh "$f" $indent_level

        # decrement indent level
        indent_level=$((indent_level-1))
    else
        # print file name
        echo -e "${BLUE}$indent_string$(basename "$f")"
    fi
done

# reset color if indent level is 0
if [ $indent_level -eq 0 ]; then
    echo -e "${NC}"
fi