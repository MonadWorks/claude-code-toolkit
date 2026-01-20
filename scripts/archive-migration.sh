#!/bin/bash

# Migration Package Archiver
# Usage: archive-migration.sh <migration_path> [content_description]
#
# This script:
# 1. Copies the migration package
# 2. Renames it with: {content}-migration-{YYYYMMDDHHmm}
# 3. Moves it to /Users/parafee41/Desktop/迁移包层

ARCHIVE_DIR="/Users/parafee41/Desktop/迁移包层"
MIGRATION_PATH="$1"
CONTENT_DESC="$2"

# Check if migration path provided
if [ -z "$MIGRATION_PATH" ]; then
    echo "Error: No migration path provided"
    exit 1
fi

# Check if path exists
if [ ! -e "$MIGRATION_PATH" ]; then
    echo "Error: Path does not exist: $MIGRATION_PATH"
    exit 1
fi

# Ensure archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Get the base name of the migration package
BASE_NAME=$(basename "$MIGRATION_PATH")

# Extract content description from path if not provided
if [ -z "$CONTENT_DESC" ]; then
    # Try to extract meaningful name (remove 'migration', '-', '_', etc.)
    CONTENT_DESC=$(echo "$BASE_NAME" | sed -E 's/[-_]?(migration|migrate|迁移)[-_]?//gi' | sed 's/^[-_]*//' | sed 's/[-_]*$//')

    # If still empty, use the original base name
    if [ -z "$CONTENT_DESC" ]; then
        CONTENT_DESC="$BASE_NAME"
    fi
fi

# Generate timestamp (精确到分钟)
TIMESTAMP=$(date +"%Y%m%d%H%M")

# Create new name: {content}-migration-{timestamp}
NEW_NAME="${CONTENT_DESC}-migration-${TIMESTAMP}"

# Full destination path
DEST_PATH="$ARCHIVE_DIR/$NEW_NAME"

# Copy the migration package
if [ -d "$MIGRATION_PATH" ]; then
    # It's a directory
    cp -r "$MIGRATION_PATH" "$DEST_PATH"
else
    # It's a file
    cp "$MIGRATION_PATH" "$DEST_PATH"
fi

if [ $? -eq 0 ]; then
    echo "✓ Migration package archived successfully"
    echo "  Source: $MIGRATION_PATH"
    echo "  Archive: $DEST_PATH"
else
    echo "Error: Failed to archive migration package"
    exit 1
fi
