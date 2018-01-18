SET _ROOT=d:\Qt\qt5
SET PATH=%_ROOT%\gnuwin32\bin;%PATH%
SET PATH=%_ROOT%\qtrepotools\bin;%_ROOT%\qtbase\bin;%PATH%
SET _ROOT=

SET _OPENSSL=C:\openssl\x86\lib
SET OPENSSL_LIBS=%_OPENSSL%\libssl.lib %_OPENSSL%\libcrypto.lib
SET _OPENSSL=

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\vc\vcvarsall.bat" x86

mkdir buildqt5-32
cd buildqt5-32

call ..\qt5\configure -release -static -accessibility -make libs -make tools ^
-no-cups -no-iconv -no-harfbuzz -no-qml-debug -no-icu -no-sql-mysql ^
-no-sql-psql -no-sql-odbc ^
-openssl-linked -I C:\openssl\x86\include ^
-prefix "d:\Qt\Qt5.9.4static-32"


rem nmake
rem nmake install

C:\Qt\Tools\QtCreator\bin\jom
C:\Qt\Tools\QtCreator\bin\jom install
