call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\vc\vcvarsall.bat" x86
REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\vc\vcvarsall.bat" x86_amd64

mkdir c:\openssl\x86

git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_0_2m

perl Configure no-asm VC-WIN32 --prefix=c:\openssl\x86
call ms\do_ms

REM perl Configure no-asm VC-WIN64A --prefix=c:\openssl\x64
REM ms\do_win64a

nmake -f ms\nt.mak
nmake -f ms\nt.mak install

