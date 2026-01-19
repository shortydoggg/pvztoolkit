
```bat

REM -- Get the FLTK 1.4.4 --
if exist pvztoolkit\ rmdir /s/q pvztoolkit
mkdir pvztoolkit
cd pvztoolkit
set folder=%CD%
if exist fltk-1.4.4\ rmdir /s/q fltk-1.4.4
git clone --branch release-1.4.4 https://github.com/shortydoggg/fltk.git fltk-1.4.4\
cd fltk-1.4.4
rmdir /s/q .git
 
cd %folder%\

REM -- Really don't need this file --
if exist ..\configure copy ..\configure fltk-1.4.x-20240531-04949f13\

REM -- Redownload pvztoolkit source --
if exist pvztoolkit_v1.22.2\ rmdir /s/q pvztoolkit_v1.22.2
git clone https://github.com/shortydoggg/pvztoolkit.git pvztoolkit_v1.22.2
rmdir /s/q pvztoolkit_v1.22.2\.git

exit /b

```