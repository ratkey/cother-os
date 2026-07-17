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

    function getColor(percentage) {
        if (percentage <= 40)
            return Theme.colPrimary;
        if (percentage <= 60)
            return Theme.colAccent;
        if (percentage <= 80)
            return Theme.colWarning;
        return Theme.colError;
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
