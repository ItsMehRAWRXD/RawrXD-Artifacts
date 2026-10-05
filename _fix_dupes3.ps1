# Fix duplicate entries for multiple files in CMakeLists.txt
$path = 'f:\~dev\rawrxd\CMakeLists.txt'
$content = Get-Content -Raw $path

$filesToFix = @(
    'src/deep2/StreamEngine.cpp',
    'src/deep2/AntiPatcher.cpp',
    'src/repointel/RepositoryUniverse.cpp',
    'src/repointel/ScopeTree.cpp'
)

foreach ($file in $filesToFix) {
    $escaped = [regex]::Escape($file)
    $pattern = '(?m)^\s+' + $escaped + '\r?\n\s+' + $escaped + '\r?\n'
    $count = [regex]::Matches($content, $pattern).Count
    if ($count -gt 0) {
        $replacement = '        ' + $file + "`r`n"
        $content = [regex]::Replace($content, $pattern, $replacement)
        Write-Output "Fixed $count duplicate pairs for $file"
    }
}

$content | Set-Content $path -Encoding UTF8 -NoNewline
Write-Output "Done"
