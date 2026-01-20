#!/bin/bash

# Migration Detection Script
# Called by Claude Code hook after Bash/Write tool use
# Checks if a migration package was created and archives it

ARCHIVE_SCRIPT="$(dirname "$0")/archive-migration.sh"
WORKING_DIR="${PWD}"

# Read tool input from stdin (passed by hook)
TOOL_INPUT=$(cat)

# Check if the operation involves migration-related paths
# Look for patterns like: migration, migrate, 迁移包, 迁移
if echo "$TOOL_INPUT" | grep -qiE '(migration|migrate|迁移)'; then

    # Try to extract the path from common patterns
    # Pattern 1: mkdir -p <path>
    # Pattern 2: cp -r <src> <dest>
    # Pattern 3: Direct path containing migration

    MIGRATION_PATH=""

    # Look for mkdir commands
    if echo "$TOOL_INPUT" | grep -qE 'mkdir.*migration|mkdir.*迁移'; then
        MIGRATION_PATH=$(echo "$TOOL_INPUT" | grep -oE '[^ ]+migration[^ ]*|[^ ]+迁移[^ ]*' | head -1)
    fi

    # Look for cp commands with migration destination
    if [ -z "$MIGRATION_PATH" ] && echo "$TOOL_INPUT" | grep -qE 'cp.*migration|cp.*迁移'; then
        # Get the last argument (destination)
        MIGRATION_PATH=$(echo "$TOOL_INPUT" | grep -oE '[^ ]+migration[^ ]*|[^ ]+迁移[^ ]*' | tail -1)
    fi

    # Look for file_path in Write tool JSON
    if [ -z "$MIGRATION_PATH" ]; then
        MIGRATION_PATH=$(echo "$TOOL_INPUT" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*migration[^"]*"' | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
    fi

    # If we found a migration path and it exists
    if [ -n "$MIGRATION_PATH" ]; then
        # Resolve to absolute path if relative
        if [[ ! "$MIGRATION_PATH" = /* ]]; then
            MIGRATION_PATH="$WORKING_DIR/$MIGRATION_PATH"
        fi

        # Check if the path exists
        if [ -e "$MIGRATION_PATH" ]; then
            echo "MIGRATION_DETECTED: $MIGRATION_PATH"
            # Call the archive script
            "$ARCHIVE_SCRIPT" "$MIGRATION_PATH"
        fi
    fi
fi
