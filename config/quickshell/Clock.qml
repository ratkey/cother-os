import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 6

    property color colPrimary: "#ffffff"

    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14
    property string clockFormat: "dddd dd-MMM hh:mm a"

    Text {
        id: clock
        text: Qt.formatDateTime(new Date(), root.clockFormat)
        color: root.colPrimary
        font {
            family: root.fontFamily
            pixelSize: root.fontSize
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
