#!/usr/bin/env bash
# Mirror Worktrunk's `wt step copy-ignored` for Cursor Agent worktrees.
# Source of truth for which gitignored files to share: .worktreeinclude
set -euo pipefail

ROOT="${ROOT_WORKTREE_PATH:-}"
if [[ -z "$ROOT" ]]; then
  echo "ROOT_WORKTREE_PATH is not set; skipping ignored-file copy" >&2
elif command -v wt >/dev/null 2>&1; then
  # Prefer Worktrunk when installed — honors .worktreeinclude ∩ gitignore.
  wt step copy-ignored --from "$ROOT" --require-include
else
  include_file=".worktreeinclude"
  if [[ ! -f "$include_file" && -f "$ROOT/.worktreeinclude" ]]; then
    include_file="$ROOT/.worktreeinclude"
  fi
  if [[ -f "$include_file" ]]; then
    while IFS= read -r pattern || [[ -n "$pattern" ]]; do
      # Strip comments and blank lines (gitignore-style)
      pattern="${pattern%%#*}"
      pattern="$(echo "$pattern" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
      [[ -z "$pattern" ]] && continue
      [[ "$pattern" == !* ]] && continue
      src="$ROOT/$pattern"
      if [[ -e "$src" ]]; then
        mkdir -p "$(dirname "$pattern")"
        cp -a "$src" "$pattern"
        echo "Copied $pattern from root worktree"
      fi
    done < "$include_file"
  fi
fi

dotnet restore RenoHome.sln
