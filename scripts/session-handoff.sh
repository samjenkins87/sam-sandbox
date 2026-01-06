#!/bin/bash
# session-handoff.sh - Quick handoff between local and cloud sessions
# Usage: ./session-handoff.sh [to-cloud|to-local] "quick summary"

set -e

ACTION=${1:-"to-cloud"}
SUMMARY=${2:-"Session handoff"}
BRANCH=$(git branch --show-current)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

if [ "$ACTION" == "to-cloud" ]; then
    echo "=== Preparing handoff: Local → Cloud ==="

    # Stage all changes
    git add -A

    # Create handoff commit
    git commit -m "handoff: local → cloud @ $TIMESTAMP

$SUMMARY

---
Run 'git pull origin $BRANCH' on cloud session to continue.
Check CLAUDE.md for context.
" || echo "Nothing to commit"

    # Push to remote
    git push -u origin "$BRANCH"

    echo ""
    echo "=== Handoff Complete ==="
    echo "Branch: $BRANCH"
    echo "Ready for cloud pickup at claude.ai/code"
    echo ""
    echo "On cloud, run:"
    echo "  git checkout $BRANCH"
    echo "  git pull origin $BRANCH"
    echo "  cat CLAUDE.md"

elif [ "$ACTION" == "to-local" ]; then
    echo "=== Preparing handoff: Cloud → Local ==="

    # Stage all changes
    git add -A

    # Create handoff commit
    git commit -m "handoff: cloud → local @ $TIMESTAMP

$SUMMARY

---
Run 'git pull origin $BRANCH' on local session to continue.
Check CLAUDE.md for context.
" || echo "Nothing to commit"

    # Push to remote
    git push -u origin "$BRANCH"

    echo ""
    echo "=== Handoff Complete ==="
    echo "Branch: $BRANCH"
    echo "Ready for local pickup in Cursor"
    echo ""
    echo "On local, run:"
    echo "  git fetch origin"
    echo "  git pull origin $BRANCH"

else
    echo "Usage: ./session-handoff.sh [to-cloud|to-local] \"summary\""
    echo ""
    echo "Examples:"
    echo "  ./session-handoff.sh to-cloud \"Finished auth UI, need backend work\""
    echo "  ./session-handoff.sh to-local \"Research complete, ready to implement\""
    exit 1
fi
