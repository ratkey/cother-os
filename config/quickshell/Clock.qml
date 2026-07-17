import Quickshell
import QtQuick
import QtQuick.Layouts
import "."

RowLayout {
    id: root
    spacing: 6

    property string clockFormat: "dddd dd-MMM hh:mm a"

    Text {
        id: clock
        text: Qt.formatDateTime(new Date(), root.clockFormat)
        color: Theme.colText
        font {
            family: Theme.fontFamily
            pixelSize: Theme.fontSize
            bold: true
        }
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), root.clockFormat)
        }
    }
}
