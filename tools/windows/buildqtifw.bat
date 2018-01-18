call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\vc\vcvarsall.bat" x86

mkdir C:\Qt\QtIFW-3.0-32\bin
mkdir buildqtifw-32
cd buildqtifw-32

REM D:\Qt\Qt5.10.1static-32\bin\qmake ..\installer-framework\installerfw.pro
D:\Qt\Qt5.9.4static-32\bin\qmake ..\installer-framework\installerfw.pro

REM nmake
C:\Qt\Tools\QtCreator\bin\jom

xcopy bin\*.exe C:\Qt\QtIFW-3.0-32\bin
