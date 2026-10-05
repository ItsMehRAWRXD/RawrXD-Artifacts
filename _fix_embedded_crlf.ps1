# Fix literal \r\n sequences in CMakeLists.txt
$path = 'f:\~dev\rawrxd\CMakeLists.txt'
$content = [System.IO.File]::ReadAllText($path)
$original = $content

# Replace literal backslash-r-backslash-n with actual CRLF
$content = $content -replace '\\r\\n', "`r`n"

if ($content -ne $original) {
    [System.IO.File]::WriteAllText($path, $content)
    Write-Output "Fixed embedded `\r\n` sequences"
} else {
    Write-Output "No embedded `\r\n` sequences found"
}
