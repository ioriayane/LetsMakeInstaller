//コンストラクタ（必須）
function Controller()
{
}

//概要ページが表示されたときのコールバック
Controller.prototype.IntroductionPageCallback = function()
{
  if(!installer.isInstaller()){               //インストーラ以外のとき      [1]
    var widget = gui.currentPageWidget()      //現在のページのオブジェクトを取得
    if(widget != null){
      //ラジオボタンの削除を選択
      widget.findChild("UninstallerRadioButton").checked = true       // [2]
      //ラジオボタンを無効状態にする
      widget.findChild("PackageManagerRadioButton").enabled = false   // [3]
      widget.findChild("UpdaterRadioButton").enabled = false
    }
  }
}
