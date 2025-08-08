import Quickshell
import QtQuick
import "../theme"
import "../../services"
import "../../components"

Item {
    id: root

    required property var screen

    implicitWidth: batteryOutline.width
    implicitHeight: batteryOutline.height
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: batteryOutline

        implicitHeight: screen.height * 0.06
        implicitWidth: screen.width * 0.015
        anchors.centerIn: parent

        radius: width / 3
        color: Colors.gray
        border.color: Colors.gray
        border.width: 4
        clip: true

        Rectangle {
            id: batteryLevel
            implicitWidth: parent.width - 2 * parent.border.width
            implicitHeight: (parent.height - 2 * parent.border.width) * Power.percentage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.border.width
            color: Power.percentage > 0.8 ? Colors.green : Power.percentage > 0.4 ? Colors.yellow : Colors.red
            radius: width / 3
        }

        Text {
            id: batteryText
            visible: !Power.charging
            anchors.centerIn: parent
            text: Power.percentage * 100
            font.family: "BlexMono Nerd Font"
            font.pointSize: 8
        }

        Image {
            id: chargingIcon
            anchors.centerIn: parent
            source: "../../assets/thunderbolt.svg"
            visible: Power.charging

            width: parent.width / 1.5
            height: parent.width / 1.5
            fillMode: Image.PreserveAspectFit
            opacity: 1
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
    }

    Tooltip {
        targetItem: root
        mouseArea: mouse
        text: Power.charging ? `${Power.percentage * 100}% (${Power.timeTo} to full)` : `${Power.percentage * 100}% (${Power.timeTo} left)`
    }
}
