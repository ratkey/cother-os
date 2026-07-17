import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import "."

RowLayout {
    id: root
    spacing: 6

    property var battery: UPower.displayDevice
    readonly property bool isReady: battery && battery.ready
    property bool charging: isReady && battery.state === UPowerDeviceState.Charging
    readonly property int level: isReady ? Math.round(battery.percentage * 100) : 0

    function getProperties(percentage) {
        if (root.charging)
            return {
                kolor: Theme.colStageFull,
                icon: String.fromCodePoint(0xF0084)
            };
        if (percentage <= 20)
            return {
                kolor: Theme.colStageEmpty,
                icon: String.fromCodePoint(0xF0079)
            };
        if (percentage <= 50)
            return {
                kolor: Theme.colStageLow,
                icon: String.fromCodePoint(0xF0083)
            };
        if (percentage <= 80)
            return {
                kolor: Theme.colStageMedium,
                icon: String.fromCodePoint(0xF0083)
            };

        return {
            kolor: Theme.colStageFull,
            icon: String.fromCodePoint(0xF007A + Math.floor(level / 10) - 1)
        };
    }

    Text {
        property var info: getProperties(root.level)
        text: info.icon
        color: info.kolor
        font {
            family: Theme.fontFamily
            pixelSize: Theme.iconSize
            bold: true
        }
    }
}
