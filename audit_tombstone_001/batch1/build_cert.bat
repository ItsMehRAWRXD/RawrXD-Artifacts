@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat" >nul 2>&1
cl /nologo /std:c++20 /EHsc /W4 /permissive- /utf-8 /I"F:\~dev\rawrxd\src\deep2" /Fe:"F:\~dev\audit_tombstone_001\batch1\deep2_sovereign_kernel_cert_001.exe" "F:\~dev\rawrxd\tools\deep2_sovereign_kernel_cert_001.cpp"
echo CL_EXIT=%ERRORLEVEL%
