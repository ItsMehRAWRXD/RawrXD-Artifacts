$ProjectRoot = 'F:\~dev\rawrxd'
$msvcRoot = 'C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC'
$vcvars   = 'C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat'
$dumpbin  = $null
if (Test-Path $msvcRoot) {
    $v = Get-ChildItem $msvcRoot -Directory | Sort-Object Name -Descending | Select-Object -First 1
    "V_NULL=" + ($null -eq $v)
    $p = Join-Path $v.FullName 'bin\Hostx64\x64\dumpbin.exe'
    "DUMPBIN_PATH=$p  EXISTS=" + (Test-Path $p)
    if (Test-Path $p) { $dumpbin = $p }
}
"DUMPBIN_SET=" + ($null -ne $dumpbin)
"VCVARS_EXISTS=" + (Test-Path $vcvars)
"TEMP=" + $env:TEMP
