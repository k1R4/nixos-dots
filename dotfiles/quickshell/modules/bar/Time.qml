import Quickshell
import QtQuick
import "../theme"
import "../../components"
import "../../services"

Item {
    id: root
    implicitHeight: time.height
    implicitWidth: time.width
    anchors.horizontalCenter: parent.horizontalCenter

    Text {
        id: time

        color: Colors.green
        text: DateTime.time
        lineHeight: 0.75
        font.family: "BlexMono Nerd Font"
        font.bold: true
        font.pointSize: 15
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
    }

    Tooltip {
        mouseArea: mouse
        targetItem: root
        text: DateTime.date
    }
}
