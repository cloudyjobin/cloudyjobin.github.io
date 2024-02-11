#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Step 1: Go to the root of the git repo
cd "$(git rev-parse --show-toplevel)"

# Step 2: Build Jekyll site with production environment
echo "Building Jekyll site..."
JEKYLL_ENV=production bundle exec jekyll b
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Jekyll build failed.${NC}"
    exit 1
fi

# Step 3: Copy contents to cloudyjobin.github.io folder
target_dir="../cloudyjobin.github.io"
if [ ! -d "$target_dir" ]; then
    echo -e "${RED}Error: Target directory '$target_dir' not found.${NC}"
    exit 1
fi

echo "Copying contents to $target_dir..."
cp -r _site/* "$target_dir"

# Step 4: Commit and push changes in cloudyjobin.github.io repo
echo "Switching to $target_dir..."
cd "$target_dir" || exit

echo "Adding changes to git..."
git add .
git commit -m "Update $(date +%Y-%m-%d_%H-%M-%S)"
echo "Pushing changes to GitHub..."
git push

# Step 5: Switch back to the original directory
echo "Switching back to the original directory..."
cd - || exit

echo -e "${GREEN}Deployment successful.${NC}"
exit 0
