import QtQuick
import "../modules/theme"

Rectangle {

    required property var screen

    default property alias content: columnItem.children

    color: Colors.black
    radius: width / 3
    // topRightRadius: 10
    // bottomRightRadius: 10
    implicitWidth: parent.width
    implicitHeight: columnItem.height ? columnItem.height + screen.height * 0.015 : 0
    anchors.horizontalCenter: parent.horizontalCenter

    Column {
        id: columnItem
        anchors.centerIn: parent
        spacing: screen.height * 0.008
    }
}
