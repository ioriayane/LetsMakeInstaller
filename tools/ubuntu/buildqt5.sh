#!/bin/sh

git clone git://code.qt.io/qt/qt5.git
cd qt5
git checkout v5.9.4
./init-repository -f --module-subset=qtbase,qttools,qtdeclarative,qttranslations
cd ..

mkdir buildqt5
cd buildqt5 

export OPENSSL_LIBS='-L/home/iori/openssl/lib -lssl -lcrypto'

../qt5/configure -release -static -accessibility -qt-xcb -make libs \
-make tools -no-eglfs -no-kms -no-cups -no-qml-debug -no-evdev -no-glib \
-no-iconv -no-icu -no-linuxfb -no-harfbuzz -fontconfig -no-mtdev \
-no-sql-mysql -no-sql-psql -no-sql-odbc -sqlite -dbus-linked \
-openssl-linked -I /home/iori/openssl/include -prefix ~/Qt/Qt5.9.4static

make
make install
