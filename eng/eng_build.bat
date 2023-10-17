
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

if exist ..\out_English rmdir /s/q ..\out_English

mkdir .\out
if not exist .\out\splash.png copy .\bin\splash.png .\out
if not exist .\out\lineup_(English).yml copy .\bin\lineup_(English).yml .\out
if not exist .\out\builds_(English).yml copy .\bin\builds_(English).yml .\out
if not exist .\out\*.reg copy .\bin\*.reg .\out

:: REM the next line to bypass debug build.
nmake -f makefile.debug

if not exist .\out\pvztoolkitd_(English).exe goto :eng

mt.exe -nologo ^
-manifest ".\res\ptk.manifest" ^
-outputresource:".\out\pvztoolkitd_(English).exe;#1"
cd .\out
ren pvztoolkitd_(English).exe %pvzdv%_(English).exe
ren pvztoolkitd_(English).pdb %pvzdv%_(English).pdb
cd..\
if exist .\out\%pvzdv%_(English).exe goto :end

:eng

:: REM the next line to bypass release build.
rem nmake -f makefile.release

if not exist .\out\pvztoolkit_(English).exe goto :end

if exist ..\dist rmdir /s/q ..\dist
if exist .\dist rmdir /s/q .\dist
mkdir .\dist

mt.exe -nologo ^
-manifest ".\res\ptk.manifest" ^
-outputresource:".\out\pvztoolkit_(English).exe;#1"
cd .\out
ren pvztoolkit_(English).exe %pvzv%_(English).exe
cd..\

REM ..\upx\upx.exe --lzma --ultra-brute .\out\%pvzv%_(English).exe

copy /y .\out\%pvzv%_(English).exe .\dist

xcopy .\bin\*.* .\dist /h/s/e

echo %pvzv%_(English).exe>.\dist\%pvzv%_(English).exe.hash
echo MD5>>./dist\%pvzv%_(English).exe.hash
echo|set /p="foobar" > ./out/%pvzv%_(English).exe.hash |certutil -hashfile ./out/%pvzv%_(English).exe MD5 | findstr /v "hash">>.\dist\%pvzv%_(English).exe.hash
echo SHA-1>>./dist\%pvzv%_(English).exe.hash
echo|set /p="foobar" > ./out/%pvzv%_(English).exe.hash |certutil -hashfile ./out/%pvzv%_(English).exe SHA1 | findstr /v "hash">>.\dist\%pvzv%_(English).exe.hash
echo SHA-256>>./dist\%pvzv%_(English).exe.hash
echo|set /p="foobar" > ./out/%pvzv%_(English).exe.hash |certutil -hashfile ./out/%pvzv%_(English).exe SHA256 | findstr /v "hash">>.\dist\%pvzv%_(English).exe.hash
echo SHA-512>>./dist\%pvzv%_(English).exe.hash
echo|set /p="foobar" > ./out/%pvzv%_(English).exe.hash |certutil -hashfile ./out/%pvzv%_(English).exe SHA512 | findstr /v "hash">>.\dist\%pvzv%_(English).exe.hash

del .\out\*.hash

gpg --armor --detach-sign .\dist\%pvzv%_(English).exe
gpg --verify .\dist\%pvzv%_(English).exe.asc .\dist\%pvzv%_(English).exe
gpg --output .\dist\shorty#3746_public.asc --export --armor




REM echo Windows Registry Editor Version 5.00>dist\clear.reg
REM echo(>>dist\clear.reg
REM echo [-HKEY_CURRENT_USER\SOFTWARE\Cube Studio\PvZ Toolkit\v1]>>dist\clear.reg

del .\out\%pvzv%_(English).exe
del .\out\*.yml
del .\out\*.reg
del .\out\*.png 

:end
