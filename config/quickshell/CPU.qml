import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "."

RowLayout {
    id: root
    spacing: 6

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

    function lerpColor(a, b, t) {
        return Qt.rgba(a.r + (b.r - a.r) * t, a.g + (b.g - a.g) * t, a.b + (b.b - a.b) * t, 1.0);
    }

    function getColor(p) {
        const stages = Theme.colStages;
        const t = Math.min(p / 100, 1.0) * (stages.length - 1);
        const i = Math.floor(t);
        if (i >= stages.length - 1)
            return stages[stages.length - 1];
        return lerpColor(stages[i], stages[i + 1], t - i);
    }

    Text {
        text: String.fromCodePoint(0xF035B)
        color: getColor(root.cpuUsage)
        font {
            family: Theme.fontFamily
            pixelSize: Theme.iconSize
            bold: true
        }
    }
    // Text {
    //     text: root.cpuUsage + "%"
    //     color: Theme.colPrimary
    //     font {
    //         family: Theme.fontFamily
    //         pixelSize: Theme.fontSize
    //         bold: true
    //     }
    // }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuReader.running = true;
        }
    }
}
