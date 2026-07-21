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

    property var normalIcons: ['󱃍', '󰁻', '󰁼', '󰁽', '󰁾', '󰁿', '󰂀', '󰂁', '󰂂', '󰁹']
    property var chargingIcons: ['󰢜', '󰂆', '󰂇', '󰂈', '󰢝', '󰂉', '󰢞', '󰂊', '󰂋', '󰂅']

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

    function getProperties(percentage) {
        if (percentage < 10)
            return { icon: '󱃍', kolor: Theme.colError };
        const idx = percentage >= 95 ? 9 : Math.floor(percentage / 10) - 1;
        const icons = root.charging ? root.chargingIcons : root.normalIcons;
        const kolor = root.charging ? Theme.colStageFull : stageColor(percentage);
        return { icon: icons[idx], kolor: kolor };
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

    // Text {
    //     text: root.level
    //     color: Theme.colText
    //     font {
    //         family: Theme.fontFamily
    //         pixelSize: Theme.textSize
    //         bold: true
    //     }
    // }
}
