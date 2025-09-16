import Quickshell
import QtQuick
import "../theme"
import "../../services"

Item {
    id: root

    required property var screen
    implicitWidth: workspaceColumn.implicitWidth
    implicitHeight: workspaceColumn.implicitHeight
    anchors.horizontalCenter: parent.horizontalCenter

    Column {
        id: workspaceColumn
        spacing: screen.height * 0.006

        Repeater {
            model: Niri.workspaces.filter(ws => ws.output == root.screen.name)

            Rectangle {
                width: screen.width * 0.008
                height: modelData.id === Niri.focusedId ? screen.width * 0.014 : screen.width * 0.008
                radius: 9999
                color: modelData.id === Niri.focusedId ? Colors.pink : Colors.gray

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: workspaceColumn
        onWheel: wheel => {
            const workspaces = Niri.workspaces.filter(ws => ws.output == root.screen.name);
            const currentIndex = workspaces.findIndex(ws => ws.id === Niri.focusedId);

            if (currentIndex !== -1) {
                let nextIndex;
                if (wheel.angleDelta.y > 0)
                    Niri.focusWorkspaceRelative(1);
                else
                    Niri.focusWorkspaceRelative(-1);
            }
        }
    }
}
