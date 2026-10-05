$ErrorActionPreference='Stop'
$ProjectRoot='F:\~dev\rawrxd'
$vcvars='C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat'
$dumpbin='C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSVC\14.44.35207\bin\Hostx64\x64\dumpbin.exe'
$RelPath='src/core/runtime_symbol_bridge.cpp'
$tmp = Join-Path $env:TEMP ("op_" + [guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
$bat=Join-Path $tmp 'b.bat'; $obj=Join-Path $tmp 'c.obj'; $stamp=Join-Path $tmp 'rc.txt'
$inc=($ProjectRoot -replace '\\','/')
$cmd = @"
call "$vcvars" >nul 2>&1
cd /d "$inc"
cl /nologo /c /std:c++20 /EHsc /W1 /I "$inc\src" /I "$inc\include" /Fo"$obj" "$RelPath" >nul 2>&1
echo %ERRORLEVEL%>"$stamp"
"@
Set-Content -LiteralPath $bat -Value $cmd -Encoding ASCII
"--- running cmd ---"
& cmd.exe /c $bat 2>&1 | Out-Null
"--- cmd returned ---"
if (Test-Path $stamp) { "RC=[" + (Get-Content -LiteralPath $stamp -Raw).Trim() + "]" } else { "NO STAMP" }
"OBJ_EXISTS=" + (Test-Path $obj)
if (Test-Path $obj) {
  $out = & $dumpbin /symbols $obj 2>&1
  "DUMPLINES=" + @($out).Count
}
Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
"DONE"
