//コンストラクタ（必須）
function Controller()
{
  //コンポーネントが追加されたときのシグナルと接続
  installer.componentAdded.connect(Controller.prototype.componentAdded)
  //インストール完了時のシグナルと接続
  installer.installationFinished.connect(
                               Controller.prototype.InstallationFinished)
  //ダウンロード失敗時のダイアログでキャンセルを選択
  installer.setMessageBoxAutomaticAnswer("OverwriteTargetDirectory"
                                       , QMessageBox.Cancel)  // [1]
}

// コンポーネントが追加されたときのスロット
Controller.prototype.componentAdded = function(component)          // [2]
{
  //必要なコンポーネントに限定する
  if(component.name == "com.vendor.product"){                      // [3]
    //コンポーネントが読み込まれたときのシグナルと接続
    component.loaded.connect(Controller.prototype.ComponentLoaded) // [4]
  }
}

//コンポーネントが読み込まれたときのスロット
Controller.prototype.ComponentLoaded = function()                  // [5]
{
  var page = gui.pageByObjectName("DynamicStandardOrCustom")
  if(page != null){
    //オリジナルページが表示されたときのシグナル（コールバック）と接続
    page.entered.connect(Controller.prototype.dynamicPageCallback) // [6]
  }
}

//概要ページが表示されたときのコールバック
Controller.prototype.IntroductionPageCallback = function()
{
  gui.clickButton(buttons.NextButton)     //次へボタンを押す
}

//オリジナルページが表示されたときのコールバック              // [7]
Controller.prototype.dynamicPageCallback = function ()
{
  var widget = gui.currentPageWidget()    //現在のページのオブジェクトを取得
  if(widget != null){
    widget.findChild("customRadioButton").checked = true
                                          //カスタムを選択    // [8]
    gui.clickButton(buttons.NextButton)   //次へボタンを押す
  }
}

//フォルダ選択が表示されたときのコールバック
Controller.prototype.TargetDirectoryPageCallback = function()
{
  gui.clickButton(buttons.NextButton)     //次へボタンを押す
}

//ライセンス許諾ページが表示されたときのコールバック
Controller.prototype.LicenseAgreementPageCallback = function()
{
  var widget = gui.currentPageWidget()    //現在のページのオブジェクトを取得
  if(widget != null){
    widget.AcceptLicenseRadioButton.checked = true
                                          //ラジオボタンの同意を選択
    gui.clickButton(buttons.NextButton)   //次へボタンを押す
  }
}

//コンポーネント選択ページが表示されたときのコールバック
Controller.prototype.ComponentSelectionPageCallback = function()
{
  var widget = gui.currentPageWidget()   //現在のページのオブジェクトを取得
  if(widget != null){
    widget.selectAll()                   //すべてのコンポーネントを選択
    gui.clickButton(buttons.NextButton)  //次へボタンを押す
  }
}

//スタートメニューディレクトリ選択ページが表示されたときのコールバック
Controller.prototype.StartMenuDirectoryPageCallback = function()
{
  gui.clickButton(buttons.NextButton)       //次へボタンを押す
}

//開始確認ページが表示されたときのコールバック
Controller.prototype.ReadyForInstallationPageCallback = function()
{
  gui.clickButton(buttons.CommitButton)     //次へボタンを押す
}

//インストール完了のコールバック
Controller.prototype.InstallationFinished = function()
{
  gui.clickButton(buttons.CommitButton)     //次へボタンを押す
}

//完了確認ページが表示されたときのコールバック
Controller.prototype.FinishedPageCallback = function()
{
  gui.clickButton(buttons.FinishButton)     //次へボタンを押す
}
