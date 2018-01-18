import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0

Dialog {
  id: root
  x: (parent.width - width) * 0.5
  y: (parent.height - height) * 0.5
  title: qsTr("Update Detail")
  //ウインドウをモーダルにする
  modal: true
  //デフォルトは非表示
  visible: false
  //Escapeキーでもキャンセル
  closePolicy: Popup.CloseOnEscape
  //YesボタンとNoボタンを配置                             [1]
  standardButtons: DialogButtonBox.Yes | DialogButtonBox.No

  //モデルへのエイリアス（外から更新情報を受け取る）
  property alias xml: updateDetailModel.xml

  //更新情報の明細を管理するモデル                   [2]
  XmlListModel {
    id: updateDetailModel
    query: "/updates/update"
    XmlRole { name: "name"; query: "@name/string()" }
    XmlRole { name: "version"; query: "@version/string()" }
    XmlRole { name: "size"; query: "@size/string()" }
  }
  //更新情報を表示
  ColumnLayout {
    anchors.fill: parent
    anchors.left: parent.left
    anchors.right: parent.right

    //案内メッセージ
    Label {
      text: qsTr("The following update was found. Do you want to update?")
      font.pointSize: 12
    }
    //明細表                                         [3]
    ListView {
      Layout.minimumHeight: 70
      Layout.fillWidth: true    //可能な限り横に広げる
      Layout.fillHeight: true   //可能な限り縦に広げる
      model: updateDetailModel
      delegate: Rectangle {
        width: parent.width
        height: label.paintedHeight * 1.1
        Label {
          id: label
          Layout.fillWidth: true    //可能な限り横に広げる
          font.pointSize: 11
          font.underline: true
          text: "%1 Ver.%2 (%3Mbyte)"
                  .arg(model.name)
                  .arg(model.version)
                  .arg(Math.round(model.size/1024/1024))
        }
      }
    }
  }
}
