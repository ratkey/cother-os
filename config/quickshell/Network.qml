import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import "."

RowLayout {
    id: root
    spacing: 6

    property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    property var active: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) : null

    readonly property real signal: active ? active.signalStrength : 0

    function getSignalInfo() {
        if (!Networking.wifiEnabled)
            return {
                kolor: Theme.colStageEmpty,
                icon: String.fromCodePoint(0xF05AA)
            };
        if (!active)
            return {
                kolor: Theme.colStageEmpty,
                icon: String.fromCodePoint(0xF092D)
            };

        let tier = signal >= 0.75 ? 4 : signal >= 0.50 ? 3 : signal >= 0.25 ? 2 : 1;

        return {
            kolor: Theme.colStageFull,
            icon: String.fromCodePoint(0xF091F + (tier - 1) * 3)
        };
    }

    Text {
        property var info: getSignalInfo()
        text: info.icon
        color: info.kolor
        font {
            family: Theme.fontFamily
            pixelSize: Theme.iconSize
            bold: true
        }
    }
}
