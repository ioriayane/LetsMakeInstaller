TEMPLATE = aux

#QtIFWとツールのパス                         [1]
qtifw_bin = $$[QT_INSTALL_BINS]/../../../Tools/QtInstallerFramework/3.0/bin
bc_command = $$shell_path($$qtifw_bin/binarycreator)
rg_command = $$shell_path($$qtifw_bin/repogen)

#コマンドに指定するファイル・フォルダ                 [2]
project_config = $$PWD/config/config.xml
project_package = $$PWD/packages
setup_file_name = setup
repository_folder_name = repository
RESOURCES = $$PWD/resources/standardorcustom.qrc

#アーキテクチャ指定の文字列（x86 or x64）                 [3]
contains(QMAKE_TARGET.arch, x86_64):target_arch = x64
else:target_arch = x86

#設定ファイルの名前をプラットフォームごとの名前に変更          　　　　[4]
win32:project_config = $$PWD/config/config_win_$${target_arch}.xml
mac:project_config = $$PWD/config/config_macos.xml
linux:project_config = $$PWD/config/config_linux.xml
dummy:project_config = dummy

#出力ファイルにプラットフォームとアーキテクチャを追加                [5]
win32:setup_file_name = $${setup_file_name}_win_$${target_arch}.exe
mac:setup_file_name = $${setup_file_name}_macos
linux:setup_file_name = $${setup_file_name}_linux

#リポジトリのフォルダ名をプラットフォームごとの名前に変更             [6]
win32:repository_folder_name = windows_$$target_arch
mac:repository_folder_name = macos
linux:repository_folder_name = linux

#元になるファイル（プロジェクトツリーに表示）                   [7]
INPUT = $$project_config \
        $$project_package \
        packages/com.vendor.product/meta/installscript.qs \
        packages/com.vendor.product/meta/ja.ts \
        packages/com.vendor.product/meta/openfileform.ui \
        packages/com.vendor.product/meta/standardorcustom.ui \
        packages/com.vendor.product/meta/package.xml

#出力ファイルのコンパイラ設定                         [8]
setup.input = INPUT
setup.output = $$setup_file_name
setup.commands = $$bc_command -c $$project_config \
                  -p $$project_package \
                  -r $$RESOURCES \
                  ${QMAKE_FILE_OUT}
setup.CONFIG += target_predeps no_link combine
# --online-onlyなどお好みで

#リポジトリのコンパイラ設定                         [9]
repository.input = INPUT
repository.output = $$repository_folder_name/Updates.xml
repository.commands = $$rg_command --update \
                    -p $$project_package ${QMAKE_FILE_OUT_PATH}
repository.CONFIG += target_predeps no_link combine

#コンパイラとして登録                             [10]
QMAKE_EXTRA_COMPILERS += setup repository
