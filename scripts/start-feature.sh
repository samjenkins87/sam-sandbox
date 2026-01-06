#!/bin/bash
# start-feature.sh - Start a new feature with proper branch and context setup
# Usage: ./start-feature.sh LIN-123 "short-description"

set -e

LINEAR_ID=${1:-""}
DESCRIPTION=${2:-""}

if [ -z "$LINEAR_ID" ] || [ -z "$DESCRIPTION" ]; then
    echo "Usage: ./start-feature.sh LIN-123 \"short-description\""
    echo ""
    echo "Examples:"
    echo "  ./start-feature.sh LIN-42 \"user-authentication\""
    echo "  ./start-feature.sh LIN-99 \"dashboard-charts\""
    exit 1
fi

# Sanitize description for branch name
BRANCH_DESC=$(echo "$DESCRIPTION" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
BRANCH_NAME="feature/${LINEAR_ID}-${BRANCH_DESC}"

echo "=== Starting New Feature ==="
echo "Linear ID: $LINEAR_ID"
echo "Description: $DESCRIPTION"
echo "Branch: $BRANCH_NAME"
echo ""

# Ensure we're on main/master and up to date
MAIN_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")
echo "Updating from $MAIN_BRANCH..."
git checkout "$MAIN_BRANCH" 2>/dev/null || git checkout main 2>/dev/null || git checkout master
git pull origin "$MAIN_BRANCH" 2>/dev/null || git pull

# Create and checkout the new branch
echo "Creating branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

# Initialize CLAUDE.md if it doesn't exist
if [ ! -f "CLAUDE.md" ]; then
    echo "Creating CLAUDE.md from template..."
    if [ -f "templates/CLAUDE.md.template" ]; then
        cp templates/CLAUDE.md.template CLAUDE.md
    else
        cat > CLAUDE.md << EOF
# CLAUDE.md - Session Context

## Current Work

**Feature**: $LINEAR_ID - $DESCRIPTION
**Branch**: $BRANCH_NAME
**Started**: $(date '+%Y-%m-%d')

## Status

- [ ] Planning
- [ ] In Progress
- [ ] Ready for Review
- [ ] Merged

## Last Session

**Date**: $(date '+%Y-%m-%d %H:%M')
**Environment**: Local

### Done
- Created feature branch

### Next Steps
1. [ ] Define requirements
2. [ ] Implement feature
3. [ ] Write tests
4. [ ] Create PR

## Notes

[Add context here as you work]
EOF
    fi
fi

# Update CLAUDE.md with feature info
echo ""
echo "=== Feature Ready ==="
echo ""
echo "Branch created: $BRANCH_NAME"
echo "CLAUDE.md initialized"
echo ""
echo "Next steps:"
echo "  1. Update CLAUDE.md with feature requirements"
echo "  2. Start coding!"
echo "  3. Use ./session-handoff.sh when switching environments"
echo ""
echo "To push this branch:"
echo "  git push -u origin $BRANCH_NAME"
