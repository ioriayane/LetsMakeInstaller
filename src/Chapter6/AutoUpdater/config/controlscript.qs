//コンストラクタ（必須）
function Controller()
{
  //インストール完了時のシグナルと接続
  installer.installationFinished.connect(
                               Controller.prototype.InstallationFinished)
}

//概要ページが表示されたときのコールバック
Controller.prototype.IntroductionPageCallback = function()
{
  gui.clickButton(buttons.NextButton)     //次へボタンを押す
}

//フォルダ選択が表示されたときのコールバック
Controller.prototype.TargetDirectoryPageCallback = function()
{
  gui.clickButton(buttons.NextButton)     //次へボタンを押す
}

//ライセンス許諾ページが表示されたときのコールバック
Controller.prototype.LicenseAgreementPageCallback = function()
{
  var widget = gui.currentPageWidget()                //現在のページのオブジェクトを取得
  if(widget != null){
    widget.AcceptLicenseRadioButton.checked = true    //ラジオボタンの同意側を選択
    gui.clickButton(buttons.NextButton)               //次へボタンを押す
  }
}

//コンポーネント選択ページが表示されたときのコールバック
Controller.prototype.ComponentSelectionPageCallback = function()
{
  var widget = gui.currentPageWidget()                //現在のページのオブジェクトを取得
  if(widget != null){
    widget.selectAll()                                //すべてのコンポーネントを選択
    if(widget.ResetComponentsButton.enabled){
      //リセットボタンが有効なら次へ
      gui.clickButton(buttons.NextButton)             //次へボタンを押す
    }else{
      //リセットボタンが無効なら終了
      gui.rejectWithoutPrompt()                       //終了確認ダイアログを出さずに終了
    }
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
