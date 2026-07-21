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

    function lerpColor(a, b, t) {
        return Qt.rgba(a.r + (b.r - a.r) * t, a.g + (b.g - a.g) * t, a.b + (b.b - a.b) * t, 1.0);
    }

    function stageColor(p) {
        const stages = Theme.colStages;
        const t = Math.min(p / 100, 1.0) * (stages.length - 1);
        const i = Math.floor(t);
        if (i >= stages.length - 1)
            return stages[stages.length - 1];
        return lerpColor(stages[i], stages[i + 1], t - i);
    }

    function getSignalInfo() {
        if (!Networking.wifiEnabled)
            return { kolor: Theme.colStageEmpty, icon: String.fromCodePoint(0xF05AA) };
        if (!active)
            return { kolor: Theme.colStageEmpty, icon: String.fromCodePoint(0xF092D) };

        let tier = signal >= 0.75 ? 4 : signal >= 0.50 ? 3 : signal >= 0.25 ? 2 : 1;
        return {
            kolor: stageColor(signal * 100),
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
