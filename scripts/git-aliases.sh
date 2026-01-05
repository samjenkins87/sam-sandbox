#!/bin/bash
# git-aliases.sh - Useful git aliases for parallel workflow
# Source this file or add these to your .gitconfig
#
# To install:
#   source ./scripts/git-aliases.sh
#
# Or add to ~/.gitconfig manually

echo "Setting up git aliases for parallel workflow..."

# Quick sync - stage all, commit, push
git config --global alias.sync '!f() { git add -A && git commit -m "${1:-sync}" && git push; }; f'

# Handoff commit with template
git config --global alias.handoff '!f() { git add -A && git commit -m "handoff: $1 → $2

$3"; }; f'

# See recent activity across all branches
git config --global alias.recent 'for-each-ref --sort=-committerdate refs/heads/ --format="%(refname:short) - %(committerdate:relative) - %(subject)"'

# See what changed across all branches today
git config --global alias.today 'log --all --oneline --since="midnight"'

# Quick branch status
git config --global alias.branches 'branch -vv'

# Show current branch name
git config --global alias.current 'branch --show-current'

# Pull current branch from origin
git config --global alias.up '!git pull origin $(git branch --show-current)'

# Push current branch to origin
git config --global alias.pub '!git push -u origin $(git branch --show-current)'

# WIP commit
git config --global alias.wip '!git add -A && git commit -m "WIP: $(git branch --show-current)"'

# Quick diff of what would be in a PR to main
git config --global alias.prdiff '!git diff $(git merge-base main HEAD)..HEAD'

echo ""
echo "=== Aliases Installed ==="
echo ""
echo "Usage:"
echo "  git sync \"message\"     - Stage all, commit, push"
echo "  git handoff local cloud \"summary\" - Create handoff commit"
echo "  git recent             - Show recent branch activity"
echo "  git today              - Show today's commits (all branches)"
echo "  git branches           - Show branches with tracking info"
echo "  git current            - Show current branch name"
echo "  git up                 - Pull current branch from origin"
echo "  git pub                - Push current branch to origin"
echo "  git wip                - Quick WIP commit"
echo "  git prdiff             - Show diff vs main"
