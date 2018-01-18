function Controller()
{
}

//概要ページが表示されたときのコールバック
Controller.prototype.IntroductionPageCallback = function()
{
  var widget = gui.currentPageWidget()  //現在のページのオブジェクト取得
  if (widget != null) {
      widget.title = "Changed by ControlScript."       //タイトルを変更
  }
}
