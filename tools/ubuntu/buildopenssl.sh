#!/bin/sh


mkdir -p ~/openssl

git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_0_2m


./Configure linux-x86_64 no-shared --prefix=~/openssl

make 
make install


