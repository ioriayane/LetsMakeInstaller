//コンストラクタ（必須）
function Controller()
{
  //インストール完了時のシグナルと接続                          [1]
  installer.installationFinished.connect(
                               Controller.prototype.InstallationFinished)
}

//概要ページが表示されたときのコールバック
Controller.prototype.IntroductionPageCallback = function()
{
  gui.clickButton(buttons.NextButton)     //次へボタンを押す    [2]
}

//フォルダ選択が表示されたときのコールバック
Controller.prototype.TargetDirectoryPageCallback = function()
{
  gui.clickButton(buttons.NextButton)     //次へボタンを押す
}

//ライセンス許諾ページが表示されたときのコールバック
Controller.prototype.LicenseAgreementPageCallback = function()
{
  var widget = gui.currentPageWidget()    //現在のページのオブジェクトを取得  [3]
  if(widget != null){
    widget.AcceptLicenseRadioButton.checked = true
                                          //ラジオボタンの同意を選択          [4]
    gui.clickButton(buttons.NextButton)   //次へボタンを押す
  }
}

//コンポーネント選択ページが表示されたときのコールバック
Controller.prototype.ComponentSelectionPageCallback = function()
{
  var widget = gui.currentPageWidget()   //現在のページのオブジェクトを取得
  if(widget != null){
    widget.selectAll()                   //すべてのコンポーネントを選択   [5]
//    widget.selectComponent("com.vendor.product") //個別で選択
    gui.clickButton(buttons.NextButton)            //次へボタンを押す
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
  gui.clickButton(buttons.CommitButton)     //次へボタンを押す    [6]
}

//インストール完了のコールバック
Controller.prototype.InstallationFinished = function()
{
  gui.clickButton(buttons.CommitButton)     //次へボタンを押す
}

//完了確認ページが表示されたときのコールバック
Controller.prototype.FinishedPageCallback = function()
{
console.log("FinishedPageCallback")
  gui.clickButton(buttons.FinishButton)     //完了ボタンを押す    [7]
}
