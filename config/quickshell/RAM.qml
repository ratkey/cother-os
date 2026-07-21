import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "."

RowLayout {
    id: root
    spacing: 6

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
        text: String.fromCodePoint(0x0EFC5)
        color: getColor(root.memUsage)
        font {
            family: Theme.fontFamily
            pixelSize: Theme.iconSize
            bold: true
        }
    }
    // Text {
    //     text: root.memUsage + "%"
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
            memReader.running = true;
        }
    }
}
