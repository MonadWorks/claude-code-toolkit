#!/bin/bash

# Auto-commit when user says positive feedback like "这很好", "目前很好", etc.
# Triggered by UserPromptSubmit hook

GIT_EMAIL="shuaizhicheng336@gmail.com"
GIT_NAME="shuaizhi"

# Read user message from stdin
USER_MESSAGE=$(cat)

# Check if message contains positive feedback patterns
# Patterns: 这很好, 目前很好, 很好, 不错, 可以, 好的, OK, 没问题
if echo "$USER_MESSAGE" | grep -qE '(这很好|目前很好|^很好|不错|^可以$|^好的|^OK$|^ok$|没问题|挺好|蛮好)'; then

    # Initialize git repo if not already initialized
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        git init --quiet
        echo "AUTO_INIT: Git repository initialized"
    fi

    # Now we're definitely in a git repository
    if git rev-parse --is-inside-work-tree &>/dev/null; then

        # Check if there are any changes to commit
        if ! git diff --quiet HEAD 2>/dev/null || ! git diff --cached --quiet 2>/dev/null || [ -n "$(git ls-files --others --exclude-standard)" ]; then

            # Configure git user for this commit
            git config user.email "$GIT_EMAIL"
            git config user.name "$GIT_NAME"

            # Stage all changes
            git add -A

            # Generate a concise commit message based on changed files
            CHANGED_FILES=$(git diff --cached --name-only | head -5)
            FILE_COUNT=$(git diff --cached --name-only | wc -l | tr -d ' ')

            if [ "$FILE_COUNT" -eq 1 ]; then
                COMMIT_MSG="update $(basename "$CHANGED_FILES")"
            elif [ "$FILE_COUNT" -le 3 ]; then
                COMMIT_MSG="update $(echo "$CHANGED_FILES" | xargs -I{} basename {} | tr '\n' ', ' | sed 's/,$//')"
            else
                # Get the most common directory or describe the change type
                MAIN_DIR=$(echo "$CHANGED_FILES" | head -1 | cut -d'/' -f1)
                COMMIT_MSG="update $MAIN_DIR and $((FILE_COUNT - 1)) more files"
            fi

            # Commit with the generated message
            git commit -m "$COMMIT_MSG" --quiet

            if [ $? -eq 0 ]; then
                echo "AUTO_COMMIT: $COMMIT_MSG"
            fi
        fi
    fi
fi
