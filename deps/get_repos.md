
```bat

REM -- Get the original FLTK that was used --
set folder=%CD%
if exist ..\..\fltk-1.4.x-20240531-04949f13\ rmdir /s/q ..\..\fltk-1.4.x-20240531-04949f13\
git clone https://github.com/shortydoggg/fltk.git ..\..\fltk-1.4.x-20240531-04949f13\
cd ..\..\fltk-1.4.x-20240531-04949f13\
git checkout 04949f13498b5406dfe54d793fc88736ec052f5b
rmdir /s/q .git
 
cd %folder%\

REM -- Really don't need this file --
if exist configure copy configure ..\..\fltk-1.4.x-20240531-04949f13\

REM -- Redownload pvztoolkit source --
if exist ..\..\pvztoolkit_v1.22.1\ rmdir /s/q ..\..\pvztoolkit_v1.22.1\
git clone https://github.com/shortydoggg/pvztoolkit.git ..\..\pvztoolkit_v1.22.1\
rmdir /s/q ..\..\pvztoolkit_v1.22.1\.git

exit /b

```