import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

RowLayout {
  id: root
  spacing: 6

  property color colPrimary: "#ffffff"

  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 14

  property int memUsage: 0

  Process {
    id: memReader
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        if (!data)
          return;
        var parts = data.trim().split(/\s+/);
        var total = parseInt(parts[1]) || 1;
        var used = parseInt(parts[2]) || 0;
        memUsage = Math.round(100 * used / total);
      }
    }
    Component.onCompleted: running = true
  }

  Text {
    text: String.fromCodePoint(0x0EFC5)
    color: root.colPrimary
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }
  Text {
    text: root.memUsage + "%"
    color: root.colPrimary
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      memReader.running = true;
    }
  }
}
