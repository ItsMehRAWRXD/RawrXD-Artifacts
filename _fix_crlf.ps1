# Fix embedded \r\n in CMakeLists.txt
$path = 'f:\~dev\rawrxd\CMakeLists.txt'
$content = Get-Content -Raw $path

$pattern = '\\r\\n'
$count = [regex]::Matches($content, [regex]::Escape($pattern)).Count
Write-Output "Found $count occurrences of literal backslash-r-backslash-n"

if ($count -gt 0) {
    $content = $content -replace [regex]::Escape('\r\n'), "`r`n"
    $content | Set-Content $path -Encoding UTF8 -NoNewline
    Write-Output "Fixed all occurrences"
} else {
    Write-Output "No occurrences found"
}
