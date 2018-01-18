import QtQuick 2.10
import QtQuick.Controls 2.3
import com.example.plugin.maintenancetool 1.0       //[1]

ApplicationWindow {
  visible: true
  width: 640
  height: 480
  title: qsTr("Hello World")

  //メンテナンス機能                                  [2]
  MaintenanceTool {
    id: maintenancetool
    //更新確認の自動実行中かフラグ
    property bool automatic: false

    //実行状態が変化した                             [3]
    onStateChanged: {
      if(state === MaintenanceTool.NotRunning){
        //更新確認が終了
        if(hasUpdate){
          //更新が見つかった
          console.debug("detail:" + updateDetails)
          updateDetailDlg.xml = updateDetails
          updateDetailDlg.open()
        }else if(!automatic){
          //見つかってなくて自動実行じゃないとき
          notFoundDlg.open()
        }
      }
    }
  }

  //更新確認の自動実行用のタイマー                   [4]
  Timer {
    id: timer
    interval: 2000
    repeat: false
    running: true
    onTriggered: {
      //自動実行として確認開始
      maintenancetool.automatic = true
      maintenancetool.checkUpdate()
    }
  }

  //メニュー
  menuBar: MenuBar {
    Menu {
      title: qsTr("&File")
      Action {
        text: qsTr("&Check update")
        onTriggered: {
          //自動実行用のタイマーを停止
          timer.running = false
          //手動実行として確認開始                     [5]
          maintenancetool.automatic = false
          maintenancetool.checkUpdate()
        }
      }
      Action {
        text: qsTr("&Exit")
        onTriggered: Qt.quit()
      }
    }
  }

  Text {
    text: qsTr("Hello World")
    anchors.centerIn: parent
  }

  //更新確認ダイアログ                             [6]
  UpdateDetailsDialog {
    id: updateDetailDlg
    onAccepted: {
      maintenancetool.startMaintenanceTool()   //メンテツール起動
      if(Qt.platform.os == "windows"){
        Qt.quit()
      }
    }
    onRejected: { console.debug("No thank you") }
  }
  //見つからなかった時の案内
  Dialog {
    id: notFoundDlg
    x: (parent.width - width) * 0.5
    y: (parent.height - height) * 0.5
    //ウインドウをモーダルにする
    modal: true
    //Escapeキーでもキャンセル
    closePolicy: Popup.CloseOnEscape
    //タイトルとメッセージ
    title: qsTr("Notification")
    Label {
        text: qsTr("Not found update.")
    }
    standardButtons: Dialog.Ok
  }
}
