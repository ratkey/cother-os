import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Variants {
  id: multiScreenRoot
  model: Quickshell.screens
  delegate: Component {

    PanelWindow {
      id: root

      required property var modelData
      screen: modelData

      // Theme
      property color colBg: "#000000"
      property color colFg: "#ffffff"
      property color colPrimary: "#ffffff"
      property color colSecondary: "#c9c9c9"
      property color colWarning: "#e0af68"
      property color colError: "#ff0000"
      property color colMuted: "#404040"
      property color colCyan: "#0db9d7"
      property color colBlue: "#7aa2f7"
      property color colYellow: "#e0af68"
      property string fontFamily: "JetBrainsMono Nerd Font"
      property int fontSize: 14

      anchors.top: true
      anchors.left: true
      anchors.right: true
      implicitHeight: 30

      color: root.colBg

      RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Workspaces {}

        // Space between
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
