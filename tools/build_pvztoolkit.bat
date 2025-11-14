
echo off
chcp 65001

REM This file is only used by the author to develop and package pvztoolkit
REM For internal use, do not run this code without understanding its purpose

set PZTK=%CD%\..\
set FLTK=%CD%\..\..\fltk

set JOM=C:\Tools\jom_1_1_4\jom.exe

if not exist %PZTK% exit
if not exist %FLTK% exit

cd /d %PZTK%

call "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" ^
x86

set INCLUDE=%FLTK%\include;%INCLUDE%
set LIB=%FLTK%\lib;%LIB%

rem goto :release

if exist .\build\pvztoolkitd.exe del .\build\pvztoolkitd.exe

if exist %JOM% (
    %JOM% -f tools/debug.makefile clean
    %JOM% -f tools/debug.makefile
) else (
    nmake -f tools/debug.makefile clean
    nmake -f tools/debug.makefile
)

if not exist .\build\pvztoolkitd.exe goto :end

mt.exe -nologo ^
-manifest ".\res\pvztoolkit.manifest" ^
-outputresource:".\build\pvztoolkitd.exe;#1"

signtool.exe sign /v ^
/fd sha256 ^
/f "OTHERS\pvztoolkit.pfx" ^
/p "9N8YsP78wr5Q" ^
/t http://timestamp.digicert.com ^
.\build\pvztoolkitd.exe

goto :end 

:release

rem --FOR POST WINDOWS XP--


nmake -f tools/release.makefile clean
nmake -f tools/release.makefile


rem --END OF POST WINDOWS XP BLOCK--


rem --FOR WINDOWS XP--


REM nmake -f tools/release.nt5.makefile clean
REM nmake -f tools/release.nt5.makefile
REM start powershell Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
REM start powershell .\nt5\patch_exe.ps1 .\build\pvztoolkit.exe
REM if not exist .\build\pvztoolkit.exe goto :end
REM goto :next


rem --END OF WINDOWS XP BLOCK--

if not exist .\build\pvztoolkit.exe goto :end

mt.exe -nologo ^
-manifest ".\res\pvztoolkit.manifest" ^
-outputresource:".\build\pvztoolkit.exe;#1"

:next
signtool.exe sign /v ^
/fd sha256 ^
/f "OTHERS\pvztoolkit.pfx" ^
/p "9N8YsP78wr5Q" ^
/t http://timestamp.digicert.com ^
.\build\pvztoolkit.exe

REM signtool.exe sign /v ^
REM /fd sha1 ^
REM /f "OTHERS\pvztoolkit.pfx" ^
REM /p "9N8YsP78wr5Q" ^
REM /t http://timestamp.digicert.com ^
REM .\build\pvztoolkit.exe

goto :end

set pvz=pvztoolkitd
if exist .\temp\ rmdir /s/q temp
if exist .\%pvz%\%pvz%.exe.hash del /q .\%pvz%\%pvz%.exe.hash
if exist .\%pvz%\%pvz%.exe.asc del /q .\%pvz%\%pvz%.exe.asc
if exist .\%pvz%\%pvz%\shorty#3746_public.asc del /q .\%pvz%\%pvz%\shorty#3746_public.asc
mkdir temp
copy /y .\%pvz%.exe .\temp\
echo %pvz%.exe>.\%pvz%.exe.hash
echo MD5>>.\%pvz%.exe.hash
echo|set /p="something" > ./temp/%pvz%.exe.hash |certutil -hashfile ./temp/%pvz%.exe MD5 | findstr /v "hash">>.\%pvz%.exe.hash
echo SHA-1>>.\%pvz%.exe.hash
echo|set /p="something" > ./temp/%pvz%.exe.hash |certutil -hashfile ./temp/%pvz%.exe SHA1 | findstr /v "hash">>.\%pvz%.exe.hash
echo SHA-256>>.\%pvz%.exe.hash
echo|set /p="something" > ./temp/%pvz%.exe.hash |certutil -hashfile ./temp/%pvz%.exe SHA256 | findstr /v "hash">>.\%pvz%.exe.hash
echo SHA-512>>.\%pvz%.exe.hash
echo|set /p="something" > ./temp/%pvz%.exe.hash |certutil -hashfile ./temp/%pvz%.exe SHA512 | findstr /v "hash">>.\%pvz%.exe.hash

if exist %pvz%.zip del /q %pvz%.zip
if exist %pvz%.rar del /q %pvz%.rar
if exist .\pvztoolkit\ rmdir /s/q .\pvztoolkit
mkdir pvztoolkit\

move /y .\temp\%pvz%.exe .\pvztoolkit\
move /y %pvz%.exe.hash .\pvztoolkit\
rmdir /s/q .\temp

gpg --armor --detach-sign .\pvztoolkit\%pvz%.exe
gpg --verify .\%pvz%.exe.asc .\pvztoolkit\%pvz%.exe
gpg --output .\pvztoolkit\shorty#3746_public.asc --export --armor

:end

if not exist .\build\splash.png copy misc\splash.png .\build
if not exist .\build\setups.yml copy misc\setups.yml .\build

exit

set WinRAR="C:\Program Files\WinRAR\WinRAR.exe"
%WinRAR% a -afrar -m5 -ma4 -r -rr1 -s %pvz%.rar "pvztoolkit\*"
%WinRAR% a -afzip -m5      -r         %pvz%.zip "pvztoolkit\*"
rmdir /s/q pvztoolkit\

exit /b

