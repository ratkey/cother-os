import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "."

Variants {
    id: multiScreenRoot
    model: Quickshell.screens
    delegate: Component {

        PanelWindow {
            id: root

            required property var modelData
            screen: modelData

            anchors.top: true
            anchors.left: true
            anchors.right: true
            implicitHeight: 30

            color: Theme.colBackground

            RowLayout {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 8

                // left side
                RowLayout {
                    Layout.minimumWidth: 250
                    Layout.fillWidth: false
                    spacing: 8
                    Clock {}
                }

                Item {
                    Layout.fillWidth: true
                }

                Workspaces {}

                Item {
                    Layout.fillWidth: true
                }

                // right side
                RowLayout {
                    Layout.minimumWidth: 250
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignRight
                    spacing: 8

                    Item {
                        Layout.fillWidth: true
                    }
                    CPU {}
                    RAM {}
                    Network {}
                    Volume {}
                    Battery {}
                }
            }
        }
    }
}
