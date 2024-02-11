#!/bin/bash
# Get current date, year, and month
DATE=$(date +"%Y-%m-%d")
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
DATEFORPOST=$(date -u '+%Y-%m-%d %H:%M:%S %z')
# Get title from user input
echo "Enter the post title:"
read TITLE

# Generate slug from title
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | tr -s ' ' '-' | sed -e 's/^-//' -e 's/-$//' | cut -c 1-30)

# Create year and month directories if they don't exist
mkdir -p _posts/$YEAR/$MONTH

# Create the file with YAML frontmatter
cat > _posts/$YEAR/$MONTH/$DATE-$SLUG.md <<EOL
---
title: "$TITLE"
date: $DATEFORPOST
categories:
- technical-writing

tags:
- azure
- kubernetes
keywords:
description: ""
---
EOL
