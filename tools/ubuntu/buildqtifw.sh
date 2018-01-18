#!/bin/sh

git clone git://code.qt.io/installer-framework/installer-framework.git
cd installer-framework
git checkout 3.0.3
cd ..

mkdir -p ~/Qt/QtIFW-3.0/bin
mkdir buildqtifw
cd buildqtifw

~/Qt/Qt5.9.4static/bin/qmake ../installer-framework/installerfw.pro \
　QTPLUGIN+=ibusplatforminputcontextplugin
make

cp bin/* ~/Qt/QtIFW-3.0/bin/

