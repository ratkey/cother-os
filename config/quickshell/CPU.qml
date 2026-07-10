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

  property int cpuUsage: 0
  property var lastCpuIdle: 0
  property var lastCpuTotal: 0

  Process {
    id: cpuReader
    command: ["cat", "/proc/stat"]
    stdout: StdioCollector {
      onStreamFinished: {
        let lines = this.text.split("\n");
        if (lines.length === 0)
          return;

        let tokens = lines[0].split(/\s+/).filter(Boolean);
        if (tokens[0] !== "cpu")
          return;

        let user = parseInt(tokens[1]);
        let nice = parseInt(tokens[2]);
        let system = parseInt(tokens[3]);
        let idle = parseInt(tokens[4]);
        let iowait = parseInt(tokens[5]);
        let irq = parseInt(tokens[6]);
        let softirq = parseInt(tokens[7]);

        let totalIdle = idle + iowait;
        let totalActive = user + nice + system + irq + softirq;
        let total = totalIdle + totalActive;

        let diffIdle = totalIdle - root.lastCpuIdle;
        let diffTotal = total - root.lastCpuTotal;

        if (root.lastCpuTotal !== 0 && diffTotal > 0) {
          root.cpuUsage = Math.round((1.0 - (diffIdle / diffTotal)) * 100);
        }

        root.lastCpuIdle = totalIdle;
        root.lastCpuTotal = total;
      }
    }
  }

  Text {
    text: String.fromCodePoint(0xF035B)
    color: root.colPrimary
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }
  Text {
    text: root.cpuUsage + "%"
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
      cpuReader.running = true;
    }
  }
}
