@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat" >nul 2>&1
cd /d F:\~dev\build_rawr_ninja
link /nologo /OUT:"F:\~dev\audit_tombstone_001\batch1\deep2_sovereign_engine_cert_001.exe" /SUBSYSTEM:CONSOLE /MACHINE:X64 /INCREMENTAL:NO /LIBPATH:F:\~dev\build_rawr_ninja "F:\~dev\audit_tombstone_001\batch1\engine_cert.obj" InferenceEngine.lib C:\VulkanSDK\1.4.357.0\Lib\vulkan-1.lib shlwapi.lib psapi.lib dbghelp.lib winhttp.lib advapi32.lib crypt32.lib dxgi.lib pdh.lib rawrxd_remote64.lib kernel32.lib user32.lib gdi32.lib ws2_32.lib bcrypt.lib ntdll.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib
echo LINK_EXIT=%ERRORLEVEL%
