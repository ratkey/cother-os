import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 8
    Repeater {
        model: 9
        Item {
            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: 15
            implicitHeight: 10
            Layout.alignment: Qt.AlignVCenter
            Layout.bottomMargin: 4

            Rectangle {
                anchors.centerIn: parent
                width: parent.isActive ? 20 : 14
                height: parent.isActive ? 10 : 7
                radius: width / 2
                color: isActive ? root.colPrimary : (ws ? root.colSecondary : root.colMuted)

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -4
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }
    }
}
