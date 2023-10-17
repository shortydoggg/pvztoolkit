
set pvzv=PvZ_Toolkit_v1.20.4
set pvzdv=PvZ_Toolkitd_v1.20.4

@echo off
chcp 65001

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" ^
x86 

cd /d %~dp0



set INCLUDE=.\fltk\include;%INCLUDE%
set LIB=.\fltk\lib;%LIB%

set INCLUDE=.\zlib\include;%INCLUDE%
set LIB=.\zlib\lib;%LIB%

nmake -f makefile.release clean

mkdir .\out
if not exist .\out\splash.png copy .\bin\splash.png .\out
if not exist .\out\lineup.yml copy .\bin\lineup.yml .\out
if not exist .\out\builds.yml copy .\bin\builds.yml .\out
if not exist .\out\*.reg copy .\bin\*.reg .\out

:: REM the next line to bypass debug build.
nmake -f makefile.debug

if not exist .\out\pvztoolkitd.exe goto :eng

mt.exe -nologo ^
-manifest ".\res\ptk.manifest" ^
-outputresource:".\out\pvztoolkitd.exe;#1"
cd .\out
ren pvztoolkitd.exe %pvzdv%.exe
ren pvztoolkitd.pdb %pvzdv%.pdb
cd..\
if exist .\eng\out\%pvzdv%.exe goto :end

:eng

:: REM the next line to bypass release build.
REM nmake -f makefile.release

if not exist .\out\pvztoolkit.exe goto :end

if exist .\eng\dist rmdir /s/q .\eng\dist
if exist .\dist rmdir /s/q .\dist
mkdir .\dist

mt.exe -nologo ^
-manifest ".\res\ptk.manifest" ^
-outputresource:".\out\pvztoolkit.exe;#1"
cd .\out
ren pvztoolkit.exe %pvzv%%.exe
cd..\

REM .\upx\upx.exe --lzma --ultra-brute .\out\%pvzv%.exe

copy /y .\out\%pvzv%.exe .\dist

xcopy .\bin\*.* .\dist /h/s/e

echo %pvzv%.exe>.\dist\%pvzv%.exe.hash
echo MD5>>./dist/%pvzv%.exe.hash
echo|set /p="foobar" > ./out/%pvzv%.exe.hash |certutil -hashfile ./out/%pvzv%.exe MD5 | findstr /v "hash">>.\dist\%pvzv%.exe.hash
echo SHA-1>>./dist/%pvzv%.exe.hash
echo|set /p="foobar" > ./out/%pvzv%.exe.hash |certutil -hashfile ./out/%pvzv%.exe SHA1 | findstr /v "hash">>.\dist\%pvzv%.exe.hash
echo SHA-256>>./dist/%pvzv%.exe.hash
echo|set /p="foobar" > ./out/%pvzv%.exe.hash |certutil -hashfile ./out/%pvzv%.exe SHA256 | findstr /v "hash">>.\dist\%pvzv%.exe.hash
echo SHA-512>>./dist/%pvzv%.exe.hash
echo|set /p="foobar" > ./out/%pvzv%.exe.hash |certutil -hashfile ./out/%pvzv%.exe SHA512 | findstr /v "hash">>.\dist\%pvzv%.exe.hash

del .\out\*.hash

gpg --armor --detach-sign .\dist\%pvzv%.exe
gpg --verify .\dist\%pvzv%.exe.asc .\dist\%pvzv%.exe
gpg --output .\dist\shorty#3746_public.asc --export --armor

REM echo Windows Registry Editor Version 5.00>dist\clear.reg
REM echo(>>dist\clear.reg
REM echo [-HKEY_CURRENT_USER\SOFTWARE\Cube Studio\PvZ Toolkit\v1]>>dist\clear.reg

del .\out\%pvzv%.exe
del .\out\*.yml
del .\out\*.reg
del .\out\*.png 

:end