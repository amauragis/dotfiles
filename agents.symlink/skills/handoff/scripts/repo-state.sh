#!/usr/bin/env bash
# Print a compact snapshot of repo state for a handoff's State section.
# Usage: scripts/repo-state.sh [base-branch]   (base defaults to main, falls back to master)
set -u

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "not a git repository: $(pwd)"
  exit 0
fi

base="${1:-}"
if [ -z "$base" ]; then
  if git show-ref --verify --quiet refs/heads/main; then base=main
  elif git show-ref --verify --quiet refs/heads/master; then base=master
  fi
fi

echo "repo:    $(basename "$(git rev-parse --show-toplevel)")"
echo "branch:  $(git rev-parse --abbrev-ref HEAD)"
echo "head:    $(git rev-parse --short HEAD) $(git log -1 --format=%s)"
if [ -n "$base" ] && [ "$base" != "$(git rev-parse --abbrev-ref HEAD)" ]; then
  echo "vs $base: $(git rev-list --count "$base"..HEAD 2>/dev/null || echo ?) commits ahead"
fi
echo
echo "uncommitted:"
git status --short || true
echo
echo "diff stat (working tree vs HEAD):"
git diff HEAD --stat | tail -n 20
