import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import "."

RowLayout {
    spacing: -2

    Repeater {
        model: 9
        Item {
            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property int focusedWs: Hyprland.focusedWorkspace?.id
            property bool isActive: focusedWs === (index + 1)

            Layout.preferredWidth: isActive ? Theme.fontSize + 20 : Theme.fontSize + 15
            Layout.preferredHeight: isActive ? Theme.fontSize : Theme.fontSize + 8
            Layout.alignment: Qt.AlignVCenter
            Layout.bottomMargin: 4

            Behavior on Layout.preferredWidth {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            readonly property color kolor: {
                if (isActive) {
                    // current active ws
                    return Theme.colAccent;
                } else if (ws) {
                    // ws with content
                    return Theme.colAccent;
                }

                return Theme.colDisabled;
            }
            readonly property color textKolor: {
                if (isActive) {
                    // current active ws
                    return Theme.colTextBackground;
                } else if (ws) {
                    // ws with content
                    return Theme.colBackground;
                }

                return Theme.colAccent;
            }

            property real endRadius: height / 2

            property real rRad: {
                if (index == 8) {
                    return endRadius;
                }
                if (focusedWs == index + 2) {
                    return 6;
                }
                return 4;
            }
            property real lRad: {
                if (index == 0) {
                    return endRadius;
                }
                if (focusedWs == index) {
                    return 6;
                }
                return 4;
            }

            Rectangle {
                anchors.fill: parent

                topLeftRadius: lRad
                bottomLeftRadius: lRad
                topRightRadius: rRad
                bottomRightRadius: rRad

                color: kolor
                border.color: Theme.colAccent
                border.width: isActive ? 2 : 0
                Text {
                    anchors.centerIn: parent
                    text: ""
                    color: textKolor
                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize
                        bold: true
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -4
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }
    }
}
