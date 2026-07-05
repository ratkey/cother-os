import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    // Theme
    property color colBg: "#000000"
    property color colFg: "#ffffff"
    property color colPrimary: "#ffffff"
    property color colSecondary: "#c9c9c9"
    property color colMuted: "#404040"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14

    SysMonitor {
      id: sys
    }

    // System data
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    // Processes and timers here...

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: root.colBg

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        // Workspaces
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

        // Space between
        Item { Layout.fillWidth: true }

        // CPU
        Text {
            text: "CPU: " + sys.cpuUsage + "%"
            color: root.colPrimary
            font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
        }

        Rectangle { width: 1; height: 16; color: root.colMuted }

        // Memory
        Text {
            text: "Mem: " + sys.memUsage + "%"
            color: root.colPrimary
            font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
        }

        Rectangle { width: 1; height: 16; color: root.colMuted }

        // Clock
        Text {
            id: clock
            color: root.colPrimary
            font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
            text: Qt.formatDateTime(new Date(), "ddd, MMM dd - hh:mm:a")
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - hh:mm:a")
            }
        }
    }
}
