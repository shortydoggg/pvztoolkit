
```bat

call "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" ^
x86

set SRC_DIR=%CD%\..\..\fltk-1.4.x-20240531-04949f13
set INS_DIR=%CD%\..\..\fltk_win10

cd /d %SRC_DIR%

git apply %SRC_DIR%\..\pvztoolkit_v1.22.0\deps\pvztoolkit_fltk.diff

mkdir build && cd build

cmake ^
-G "NMake Makefiles" ^
-D CMAKE_BUILD_TYPE=MinSizeRel ^
-D CMAKE_INSTALL_PREFIX=%INS_DIR% ^
-D FLTK_BUILD_EXAMPLES=OFF ^
-D FLTK_BUILD_FLTK_OPTIONS=OFF ^
-D FLTK_BUILD_FLUID=OFF ^
-D FLTK_BUILD_FORMS=OFF ^
-D FLTK_BUILD_GL=OFF ^
-D FLTK_BUILD_SHARED_LIBS=OFF ^
-D FLTK_BUILD_TEST=OFF ^
-D FLTK_GRAPHICS_GDIPLUS=ON ^
-D FLTK_MSVC_RUNTIME_DLL=OFF ^
-D FLTK_OPTION_FILESYSTEM_SUPPORT=ON ^
-D FLTK_OPTION_LARGE_FILE=ON ^
-D FLTK_OPTION_OPTIM="/GR- /D_HAS_EXCEPTIONS=0 /GL" ^
-D FLTK_OPTION_PRINT_SUPPORT=OFF ^
-D FLTK_OPTION_STD=OFF ^
-D FLTK_OPTION_SVG=ON ^
-D FLTK_USE_SYSTEM_LIBJPEG=OFF ^
-D FLTK_USE_SYSTEM_LIBPNG=OFF ^
-D FLTK_USE_SYSTEM_ZLIB=OFF ^
-S ..

nmake && nmake install

copy /y %SRC_DIR%\build\src\CMakeFiles\fltk.dir\fltk.pdb %INS_DIR%\lib
copy /y %SRC_DIR%\build\src\CMakeFiles\fltk_images.dir\fltk_images.pdb %INS_DIR%\lib
copy /y %SRC_DIR%\build\jpeg\CMakeFiles\fltk_jpeg.dir\fltk_jpeg.pdb %INS_DIR%\lib
copy /y %SRC_DIR%\build\png\CMakeFiles\fltk_png.dir\fltk_png.pdb %INS_DIR%\lib
copy /y %SRC_DIR%\build\zlib\CMakeFiles\fltk_z.dir\fltk_z.pdb %INS_DIR%\lib

```

```txt

rem debug version

-D CMAKE_BUILD_TYPE=Debug ^
-D FLTK_OPTION_OPTIM="/GL-" ^

copy /y %SRC_DIR%\build\src\CMakeFiles\fltk.dir\fltk.pdb %INS_DIR%\lib
copy /y %SRC_DIR%\build\src\CMakeFiles\fltk_images.dir\fltk_images.pdb %INS_DIR%\lib
copy /y %SRC_DIR%\build\jpeg\CMakeFiles\fltk_jpeg.dir\fltk_jpeg.pdb %INS_DIR%\lib
copy /y %SRC_DIR%\build\png\CMakeFiles\fltk_png.dir\fltk_png.pdb %INS_DIR%\lib
copy /y %SRC_DIR%\build\zlib\CMakeFiles\fltk_z.dir\fltk_z.pdb %INS_DIR%\lib

```

```txt

rem release version

-D CMAKE_BUILD_TYPE=MinSizeRel ^
-D FLTK_OPTION_OPTIM="/GR- /D_HAS_EXCEPTIONS=0 /GL" ^

REM copy /y %SRC_DIR%\build\src\CMakeFiles\fltk.dir\fltk.pdb %INS_DIR%\lib
REM copy /y %SRC_DIR%\build\src\CMakeFiles\fltk_images.dir\fltk_images.pdb %INS_DIR%\lib
REM copy /y %SRC_DIR%\build\jpeg\CMakeFiles\fltk_jpeg.dir\fltk_jpeg.pdb %INS_DIR%\lib
REM copy /y %SRC_DIR%\build\png\CMakeFiles\fltk_png.dir\fltk_png.pdb %INS_DIR%\lib
REM copy /y %SRC_DIR%\build\zlib\CMakeFiles\fltk_z.dir\fltk_z.pdb %INS_DIR%\lib

```

```txt

rem static_nt5

-D FLTK_GRAPHICS_GDIPLUS=OFF ^
-D FLTK_OPTION_OPTIM="/arch:IA32 -D_WIN32_WINNT=0x0501 -D_USING_V110_SDK71_" ^

REM copy /y %SRC_DIR%\build\src\CMakeFiles\fltk.dir\fltk.pdb %INS_DIR%\lib
REM copy /y %SRC_DIR%\build\src\CMakeFiles\fltk_images.dir\fltk_images.pdb %INS_DIR%\lib
REM copy /y %SRC_DIR%\build\jpeg\CMakeFiles\fltk_jpeg.dir\fltk_jpeg.pdb %INS_DIR%\lib
REM copy /y %SRC_DIR%\build\png\CMakeFiles\fltk_png.dir\fltk_png.pdb %INS_DIR%\lib
REM copy /y %SRC_DIR%\build\zlib\CMakeFiles\fltk_z.dir\fltk_z.pdb %INS_DIR%\lib

```
