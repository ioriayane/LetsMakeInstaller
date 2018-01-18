//コンストラクタ
function Component()
{
  //インストール完了時のシグナル（つまり完了確認ページが表示されたときのシグナル）
  installer.installationFinished.connect(this
             , Component.prototype.installationFinishedPageIsShown)  // [1]
  //完了ボタン押下時のシグナル
  installer.finishButtonClicked.connect(this
             , Component.prototype.installationFinished)             // [2]
}

//コンポーネント選択のデフォルト確認
Component.prototype.isDefault = function()
{
  return true
}

//インストール動作を追加
Component.prototype.createOperations = function()
{
  try{
    // createOperationsの基本処理を実行
    component.createOperations()

    if(systemInfo.kernelType === "winnt"){
      //Readme.txt用のショートカット
      component.addOperation("CreateShortcut"
                             , "@TargetDir@/README.txt"
                             , "@StartMenuDir@/README.lnk"
                             , "workingDirectory=@TargetDir@"
                             , "iconPath=%SystemRoot%/system32/SHELL32.dll"
                             , "iconId=2")
      //実行ファイル用のショートカット
      component.addOperation("CreateShortcut"
                             , "@TargetDir@/HelloWorld.exe"
                             , "@StartMenuDir@/HelloWorld.lnk"
                             , "workingDirectory=@TargetDir@"
                             , "iconPath=@TargetDir@/HelloWorld.exe"
                             , "iconId=0")

    }else if(systemInfo.kernelType == "linux"){
      //ランチャー用アイコン
      component.addOperation("InstallIcons", "@TargetDir@/icons/")
      //実行ファイル用のショートカット
      component.addOperation("CreateDesktopEntry"
                           , "HelloWorld.desktop"
                           , "Type=Application\nExec=@TargetDir@/HelloWorld\nPath=@TargetDir@\n"
                            +"Name=Hello World\nGenericName=Example Application.\n"
                            +"Icon=HelloWorld\nTerminal=false\nCategories=Development"
                           )
    }
  }catch(e){
    print(e)
  }
}

//インストール完了時のスロット
Component.prototype.installationFinishedPageIsShown = function ()
{
  try{
    //インストールが成功したときだけ追加処理                        // [3]
    if(installer.status === QInstaller.Success){
      //完了ページにレイアウトを追加                                // [4]
      if(installer.addWizardPageItem(component
                                , "OpenFileForm"
                                , QInstaller.InstallationFinished)){
        //Linuxのときだけ、アプリの実行を非表示にする              // [5]
        if(installer.value("os") === "x11"){
          var form = component.userInterface("OpenFileForm")
          form.runAppCheckBox.visible = false
        }
      }
    }
  }catch(e){
    print(e)
  }
}

//完了ボタン押下時のスロット
Component.prototype.installationFinished = function ()
{
  try{
    if(installer.status === QInstaller.Success){
      //追加したレイアウトのオブジェクト取得
      var form = component.userInterface("OpenFileForm")            // [6]
      //スキームと拡張子
      var scheme = "file://"
      var ext = ""
      if(installer.value("os") === "win"){
        scheme = "file:///"
        ext = ".exe"
      }else if(installer.value("os") === "mac"){
        ext = ".app"
      }
      //チェック状態を確認して実行
      if(form.openReadmeCheckBox.checked){                          // [7]
        QDesktopServices.openUrl(scheme + installer.value("TargetDir")
                                       + "/README.txt")             // [8]
      }
      if(form.runAppCheckBox.checked){
        QDesktopServices.openUrl(scheme + installer.value("TargetDir")
                                        + "/HelloWorld" + ext)
      }
    }
  }catch(e){
    print(e)
  }
}

