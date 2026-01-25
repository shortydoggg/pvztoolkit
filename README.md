**English | [简体中文](./README.Chinese_Simplified.md)**

# PvZ Toolkit

Plants vs. Zombies Tool Kit

## Screenshots

![PvZ Toolkit](https://github.com/shortydoggg/pvztoolkit/raw/master/docs/pvztoolkit_en.gif)

## Download Link

Official Website: [https://pvz.lmintlcx.com/toolkit/](https://pvz.lmintlcx.com/toolkit/)

GitHub Releases: [https://github.com/shortydoggg/pvztoolkit/releases](https://github.com/shortydoggg/pvztoolkit/releases)

## Change Log

Latest Version: 1.22.2 (2026-01-24)

[CHANGELOG.md](https://github.com/shortydoggg/pvztoolkit/blob/master/CHANGELOG.md)

## Supported Platforms

PvZ Toolkit supports all mainstream versions of Microsoft Windows.

| Operating System | Service Pack      | Architecture |
| ---------------- | ----------------- | ------------ |
| Windows 2000     | RTM / ... / SP4   | x86          |
| Windows XP       | RTM / ... / SP3   | x86          |
| Windows Vista    | RTM / SP1 / SP2   | x86 / WoW64  |
| **Windows 7**    | RTM / SP1         | x86 / WoW64  |
| Windows 8        | RTM               | x86 / WoW64  |
| Windows 8.1      | RTM               | x86 / WoW64  |
| **Windows 10**   | 1507 / ... / 22H2 | x86 / WoW64  |
| **Windows 11**   | 21H2 / ...        | WoW64        |

> On Windows 8 and later, some button texts will be embellished with Emoji emoticons.

## Supported PvZ Versions

PvZ Toolkit supports all known official versions of Plants vs. Zombies 1 on PC (https://pvz.lmintlcx.com/download/).

- 0.1.1.1014 Beta (en) (partial support)
- 0.9.9.1029 Beta (en) (partial support)
- 1.0.0.1051 (en)
- 1.2.0.1065 (en)
- 1.0.4.7924 (es)
- 1.0.7.3556 (es)
- 1.0.7.3467 (ru)
- 1.2.0.1073 GOTY Origin (en)
- 1.2.0.1093 GOTY Origin (de/es/fr/it)
- 1.2.0.1096 GOTY Steam (en)
- 1.1.0.1056 GOTY (ja)
- 1.1.0.1056 GOTY 2010 (zh) (2010/08/02)
- 1.1.0.1056 GOTY 2012 (zh) (2012/06/05)
- 1.1.0.1056 GOTY 2012 (zh) (2012/07/17)

## Size Scaling

- Zoom in: Hold ***Ctrl*** and ***+*** buttons
- Shrink: Hold ***Ctrl*** and ***-*** buttons
- Reduction: Press ***Esc*** button
- 100% Size: Hold ***Ctrl*** and ***0*** buttons

Supported Scaling Ratios: 50%, 67%, 80%, 90%, 100%, 125%, 150%, 200%, 250%, 300%, 400%, 500%

## Build

PvZ Toolkit is developed using Visual C++ and FLTK library with zlib.

> Requirements: >= C++17, Visual Studio >= 2017 15.9, CMake >= 3.15.

> Compile FLTK + zlib libraries: [build_fltk_zlib.md](https://github.com/shortydoggg/pvztoolkit/blob/master/deps/build_fltk_zlib.md)

```bat

REM Get the project source code

git clone https://github.com/shortydoggg/pvztoolkit

REM Switch to the project folder

cd pvztoolkit

REM Create and switch to a temporary folder

mkdir build && cd build

REM Start the compilation environment (please modify the compiler installation directory according to the actual situation)

call "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" ^
x86

REM Configure the project (please modify the build type and dependent library path according to the actual situation)

cmake ^
-G "NMake Makefiles" ^
-D CMAKE_BUILD_TYPE=MinSizeRel ^
-D FLTK_DIR=%CD%\..\..\fltk\CMake ^
-S ..

REM Compile the project

cmake --build .

REM The finished file pvztoolkit.exe is located in the build folder

```

Conditional compilation switches:
`_PVZ_BETA_LEAK_SUPPORT` supports leaked beta versions
`_PTK_CHINESE_UI` Chinese language interface

## Roadmap

> PvZ Toolkit is the sequel to PvZ Tools.<br>It was born to solve some obvious shortcomings of previous work.

Problems with old PvZ Tools:

- Too big the program.
- Too slow when start-up.
- Too large gaps between controls.
- Too ugly the extended English layout.
- Too high proportion of communication code.
- Too inconvenient to support multiple versions.
- Too many useless functions.
- Too long the Lineup String.

Goals for new PvZ Toolkit:

~~TODO: I DON'T KNOW HOW TO FUCKING TRANSLATE THEM PROPERLY !!!~~

> Lineup Code Developer Documentation: [rfc1437.txt](https://github.com/shortydoggg/pvztoolkit/blob/master/docs/rfc1437.txt)

## Known Issues

- User interface style is ugly, no accessibility support.
- Implementation from old trainers, leaving bugs unfixed.

## License

PvZ Toolkit is licensed under version 3 of the GNU General Public License.

## Credit

PvZ Toolkit was originally based on [zhumxiang/PVZ_Helper](https://github.com/zhumxiang/PVZ_Helper).

Got a lot of help from [Lazuplis-Mei](https://github.com/Lazuplis-Mei) / [63enjoy](https://github.com/63enjoy) / [infdust](https://github.com/infdust).

