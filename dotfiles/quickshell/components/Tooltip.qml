import Quickshell
import QtQuick
import "../modules/theme"

PopupWindow {
    id: root
    required property var mouseArea
    required property var targetItem
    required property string text

    visible: root.mouseArea.containsMouse

    anchor.item: root.targetItem
    anchor.rect.x: root.mouseArea.mouseX + 14
    anchor.rect.y: root.mouseArea.mouseY + 14
    implicitWidth: tooltipRect.width
    implicitHeight: tooltipRect.height
    color: "transparent"

    Rectangle {
        id: tooltipRect

        anchors.centerIn: parent
        color: Colors.gray
        opacity: root.mouseArea.containsMouse ? 1 : 0
        implicitWidth: tooltipText.contentWidth + 12
        implicitHeight: tooltipText.contentHeight + 6
        radius: 10

        Text {
            id: tooltipText
            text: root.text
            anchors.centerIn: parent
            color: "white"
            font.pointSize: 10
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 800
            }
        }
    }

    Behavior on visible {
        enabled: !root.visible
        NumberAnimation {
            duration: 600
        }
    }
}
