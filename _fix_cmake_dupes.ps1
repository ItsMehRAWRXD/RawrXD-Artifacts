# Remove duplicate Deep2Engine.cpp entries within WIN32IDE_SOURCES blocks
$path = 'f:\~dev\rawrxd\CMakeLists.txt'
$lines = Get-Content $path

# Find all lines that have 'src/deep2/Deep2Engine.cpp' followed immediately by another 'src/deep2/Deep2Engine.cpp'
# within a WIN32IDE_SOURCES block context
$inWin32Block = $false
$result = @()
$skipNext = $false

for ($i=0; $i -lt $lines.Count; $i++) {
    if ($skipNext) {
        $skipNext = $false
        continue
    }

    $line = $lines[$i]
    $trim = $line.Trim()

    # Detect block boundaries
    if ($trim -match 'set\s*\(\s*WIN32IDE_SOURCES' -or $trim -match 'list\s*\(\s*APPEND\s+WIN32IDE_SOURCES') {
        $inWin32Block = $true
        $result += $line
        continue
    }
    if ($inWin32Block -and $trim -match '^\)') {
        $inWin32Block = $false
        $result += $line
        continue
    }

    # Check if this line is a duplicate of the next line (both are src/deep2/Deep2Engine.cpp)
    if ($inWin32Block -and $trim -match '^\s*src/deep2/Deep2Engine\.cpp' -and $i+1 -lt $lines.Count) {
        $nextTrim = $lines[$i+1].Trim()
        if ($nextTrim -match '^\s*src/deep2/Deep2Engine\.cpp') {
            # Skip the next line (duplicate)
            $skipNext = $true
        }
    }

    $result += $line
}

# Count changes
$originalCount = $lines.Count
$newCount = $result.Count
$removed = $originalCount - $newCount

Write-Output "Removed $removed duplicate lines"

# Write back
$result | Set-Content $path -Encoding UTF8
