QT += quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

#邪魔になるので削除
# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /opt/$${TARGET}/bin
#!isEmpty(target.path): INSTALLS += target

#アーキテクチャ指定の文字列（x86 or x64）
contains(QMAKE_TARGET.arch, x86_64):target_arch = x64
else:target_arch = x86

#インストール先                                          [1]
CONFIG(installer){
  #インストーラー作成ビルドのときはパッケージフォルダへ
  install_dir = $$PWD/../installer/packages/com.vendor.product/data
}else{
  #普段はビルドフォルダへ
  win32:{
    CONFIG(debug,debug|release):install_dir = $$OUT_PWD/debug
    else: install_dir = $$OUT_PWD/release
  }else{
    install_dir = $$OUT_PWD
  }
}

#翻訳編集ファイルの設定                                      [2]
TRANSLATIONS += translations/$${TARGET}_ja_JP.ts \
                translations/$${TARGET}_de_DE.ts
#lupdate HelloWorld.pro
#lrelease HelloWorld.pro

#翻訳ファイルのコピー設定                                  [3]
translations.path = $$install_dir/translations
mac:translations.path = \
          $$install_dir/$${TARGET}.app/Contents/MacOS/translations
translations.files = $$PWD/translations/*.qm
#qmファイルが存在しないとmakefileに追加されないので注意

#Readmeやランタイムなどその他ファイルをコピーする設定              [4]
others.path = $$install_dir
others.files = $$PWD/readme.txt
win32:others.files += $$PWD/../runtime/$${target_arch}/*

#makeコマンドの設定（QMAKE_POST_LINK用）                  [5]
command_sep = &&
make_command = make -f $(MAKEFILE)
win32:make_command = nmake -f $(MAKEFILE)

CONFIG(installer){
  #インストーラー作成ビルドのときの処理
  # qmake CONFIG+=installer -spec win32-msvc hoge.pro

  #実行ファイルなどのコピー設定                              [6]
  target.path = $$install_dir
  INSTALLS += target translations others
  #macではtargetコピー前にhoge.appの削除が走るので翻訳などは後ろに追加する必要あり

  #インストーラー作成ビルドのときのコピー先をクリア                   [7]
  clean_install_dir.target = clean_install_dir
  win32{
    clean_install_dir.commands = if exist $$shell_path($$install_dir) \
                                (rmdir /s /q $$shell_path($$install_dir))
  }else{
    clean_install_dir.commands = test -d $$shell_path($$install_dir) \
                                && rm -r $$shell_path($$install_dir/*)
  }
  QMAKE_EXTRA_TARGETS += clean_install_dir

  #デプロイツール（windeployqt/macdeployqt）の解析対象の実行ファイルパスを作成 [8]
  deploy_file = $$install_dir/$${TARGET}
  win32:deploy_file = $$shell_path($${deploy_file}.exe)
  mac:deploy_file = $$shell_path($${deploy_file}.app)
  #デプロイツール（windeployqt/macdeployqt）のコマンド設定               [9]
  win32:deploy_tool = $$[QT_INSTALL_BINS]/windeployqt
  mac:deploy_tool = $$[QT_INSTALL_BINS]/macdeployqt
  deploy_tool = $$shell_path($$deploy_tool)
  deploy.target = deploy
  deploy.depends = install
  win32:deploy.commands = $$deploy_tool --qmldir $$PWD $$deploy_file
  macos:deploy.commands = $$deploy_tool $$deploy_file -qmldir=$$PWD
  QMAKE_EXTRA_TARGETS += deploy
#コマンドのパラメーターの順番はWinとMacで違う
# -libpath=../hoge/lib みたいなのを追加したりもするのでお好みで
#hint  ${DEPLOY_TOOL} ${DEST_PATH}/hello.app -qmldir=../src -libpath=../hoge/lib

  #ビルド後にデプロイ処理を実行                                      [10]
  QMAKE_POST_LINK += $$make_command clean_install_dir $$command_sep
  QMAKE_POST_LINK += $$make_command deploy
}else{
  #通常時はインストールコマンドだけで翻訳ファイルなどをコピー                   [11]
  INSTALLS += translations
  #ビルド後にコピー処理を実行                                        [12]
  QMAKE_POST_LINK += $$make_command install
}
