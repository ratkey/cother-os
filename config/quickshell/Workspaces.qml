import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "."

RowLayout {
    spacing: 8
    Repeater {
        model: 9
        Item {
            implicitWidth: 15
            implicitHeight: 10
            Layout.alignment: Qt.AlignVCenter
            Layout.bottomMargin: 4

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            readonly property color kolor: {
                if (isActive) {
                    return Theme.colAccent;
                } else if (ws) {
                    return Theme.colAccent;
                }

                return Theme.colDisabled;
            }

            Rectangle {
                anchors.centerIn: parent
                width: parent.isActive ? 25 : 20
                height: parent.isActive ? 15 : 10
                radius: width / 2
                color: kolor
                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -4
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }
    }
}
