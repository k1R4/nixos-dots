import Quickshell
import Quickshell.Io
import QtQuick
import "../theme"
import "../../components"

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData
            screen: modelData

            anchors {
                top: true
                bottom: true
                left: true
            }

            // margins.left: 7

            implicitWidth: screen.width * 0.024
            color: Colors.black

            // Top
            VerticalNotch {
                screen: bar.screen
                anchors.top: parent.top
                anchors.topMargin: bar.screen.height * 0.03
            }

            // Center
            VerticalNotch {
                screen: bar.screen
                anchors.centerIn: parent

                NiriWorkspaces {
                    screen: bar.screen
                }
            }

            // Bottom
            VerticalNotch {
                screen: bar.screen
                anchors.bottom: parent.bottom
                anchors.bottomMargin: bar.screen.height * 0.01

                Battery {
                    screen: bar.screen
                }
                Time {}
            }
        }
    }
}
