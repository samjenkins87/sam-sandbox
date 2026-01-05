#!/bin/bash
# parallel-status.sh - Check status of all parallel work streams
# Usage: ./parallel-status.sh

set -e

echo "=== Parallel Work Stream Status ==="
echo "Current branch: $(git branch --show-current)"
echo "Timestamp: $(date '+%Y-%m-%d %H:%M')"
echo ""

# Fetch latest from all remotes
echo "Fetching latest..."
git fetch --all --quiet

echo ""
echo "=== Active Branches (by recency) ==="
echo ""
printf "%-40s %-20s %s\n" "BRANCH" "LAST UPDATED" "LATEST COMMIT"
printf "%-40s %-20s %s\n" "------" "------------" "-------------"

git for-each-ref --sort=-committerdate refs/heads/ \
    --format='%(refname:short)|%(committerdate:relative)|%(subject)' | \
    head -10 | \
    while IFS='|' read branch date subject; do
        # Truncate subject if too long
        if [ ${#subject} -gt 40 ]; then
            subject="${subject:0:37}..."
        fi
        printf "%-40s %-20s %s\n" "$branch" "$date" "$subject"
    done

echo ""
echo "=== Uncommitted Changes ==="
if git diff --quiet && git diff --cached --quiet; then
    echo "Working directory clean"
else
    git status --short
fi

echo ""
echo "=== Recent Cross-Branch Activity ==="
echo "(Commits across all branches in last 24h)"
echo ""
git log --all --oneline --since="24 hours ago" --format="%h %s (%an, %ar)" | head -10

echo ""
echo "=== CLAUDE.md Last Updated ==="
if [ -f "CLAUDE.md" ]; then
    stat -c "Modified: %y" CLAUDE.md 2>/dev/null || stat -f "Modified: %Sm" CLAUDE.md
else
    echo "No CLAUDE.md found in current directory"
fi
