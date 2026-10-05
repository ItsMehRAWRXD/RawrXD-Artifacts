# Fix duplicate Deep2Engine.cpp entries in CMakeLists.txt
$path = 'f:\~dev\rawrxd\CMakeLists.txt'
$content = Get-Content -Raw $path

# Replace every occurrence of two consecutive src/deep2/Deep2Engine.cpp lines with one
$pattern = '(?m)^     src/deep2/Deep2Engine\.cpp\r?\n     src/deep2/Deep2Engine\.cpp\r?\n'
$replacement = '     src/deep2/Deep2Engine.cpp\r\n'

$count = [regex]::Matches($content, $pattern).Count
Write-Output "Found $count duplicate pairs"

if ($count -gt 0) {
    $content = [regex]::Replace($content, $pattern, $replacement)
    $content | Set-Content $path -Encoding UTF8 -NoNewline
    Write-Output "Fixed $count duplicate pairs"
} else {
    Write-Output "No duplicates found"
}
