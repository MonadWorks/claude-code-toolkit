#!/bin/bash

# Check for recently created migration packages and archive them
# This script is called by Claude Code hook after tool execution

ARCHIVE_DIR="/Users/parafee41/Desktop/迁移包层"
ARCHIVE_SCRIPT="$(dirname "$0")/archive-migration.sh"
WORKING_DIR="${PWD}"
MARKER_FILE="/tmp/claude-migration-archived"

# Find migration directories/files created in the last 2 minutes
# Patterns: *migration*, *migrate*, *迁移*
find_migration() {
    find "$WORKING_DIR" -maxdepth 3 -mmin -2 \( \
        -name "*migration*" -o \
        -name "*migrate*" -o \
        -name "*迁移*" \
    \) -type d 2>/dev/null | head -5
}

# Get list of migration packages
MIGRATIONS=$(find_migration)

if [ -n "$MIGRATIONS" ]; then
    while IFS= read -r migration_path; do
        if [ -n "$migration_path" ] && [ -e "$migration_path" ]; then
            # Check if we already archived this exact path recently (avoid duplicates)
            HASH=$(echo "$migration_path" | md5 2>/dev/null || echo "$migration_path" | md5sum | cut -d' ' -f1)
            MARKER="$MARKER_FILE-$HASH"

            if [ ! -f "$MARKER" ]; then
                # Archive the migration package
                "$ARCHIVE_SCRIPT" "$migration_path"

                # Mark as archived (expires in 10 minutes)
                touch "$MARKER"
                (sleep 600 && rm -f "$MARKER") &>/dev/null &
            fi
        fi
    done <<< "$MIGRATIONS"
fi
