# Mirror Worktrunk's `wt step copy-ignored` for Cursor Agent worktrees.
# Source of truth for which gitignored files to share: .worktreeinclude
$ErrorActionPreference = 'Stop'

$root = $env:ROOT_WORKTREE_PATH
if ([string]::IsNullOrWhiteSpace($root)) {
    Write-Host "ROOT_WORKTREE_PATH is not set; skipping ignored-file copy"
} elseif (Get-Command wt -ErrorAction SilentlyContinue) {
    & wt step copy-ignored --from $root --require-include
} else {
    $includeFile = ".worktreeinclude"
    if (-not (Test-Path $includeFile) -and (Test-Path (Join-Path $root ".worktreeinclude"))) {
        $includeFile = Join-Path $root ".worktreeinclude"
    }
    if (Test-Path $includeFile) {
        Get-Content $includeFile | ForEach-Object {
            $pattern = $_
            $hash = $pattern.IndexOf('#')
            if ($hash -ge 0) { $pattern = $pattern.Substring(0, $hash) }
            $pattern = $pattern.Trim()
            if ([string]::IsNullOrWhiteSpace($pattern)) { return }
            if ($pattern.StartsWith('!')) { return }
            $src = Join-Path $root $pattern
            if (Test-Path $src) {
                $destDir = Split-Path -Parent $pattern
                if ($destDir -and -not (Test-Path $destDir)) {
                    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
                }
                Copy-Item -Path $src -Destination $pattern -Recurse -Force
                Write-Host "Copied $pattern from root worktree"
            }
        }
    }
}

dotnet restore RenoHome.sln
