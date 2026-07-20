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

    property var levels: {
        "lvl_10": {
            "charging": {
                icon: '󰢜',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󱃍',
                kolor: Theme.colStage1
            }
        },
        "lvl_20": {
            "charging": {
                icon: '󰂆',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰁻',
                kolor: Theme.colStage2
            }
        },
        "lvl_30": {
            "charging": {
                icon: '󰂇',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰁼',
                kolor: Theme.colStage3
            }
        },
        "lvl_40": {
            "charging": {
                icon: '󰂈',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰁽',
                kolor: Theme.colStage4
            }
        },
        "lvl_50": {
            "charging": {
                icon: '󰢝',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰁾',
                kolor: Theme.colStage5
            }
        },
        "lvl_60": {
            "charging": {
                icon: '󰂉',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰁿',
                kolor: Theme.colStage5
            }
        },
        "lvl_70": {
            "charging": {
                icon: '󰢞',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰂀',
                kolor: Theme.colStage7
            }
        },
        "lvl_80": {
            "charging": {
                icon: '󰂊',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰂁',
                kolor: Theme.colStage8
            }
        },
        "lvl_90": {
            "charging": {
                icon: '󰂋',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰂂',
                kolor: Theme.colStage8
            }
        },
        "lvl_100": {
            "charging": {
                icon: '󰂅',
                kolor: Theme.colStageFull
            },
            "normal": {
                icon: '󰁹',
                kolor: Theme.colStageFull
            }
        },
        "alert": {
            icon: '󱃍',
            kolor: Theme.colError
        }
    }

    function getProperties(percentage) {
        var state = root.charging ? "charging" : "normal";
        switch (true) {
        case percentage >= 95:
            return root.levels.lvl_100[state];
        case percentage >= 90:
            return root.levels.lvl_90[state];
        case percentage >= 80:
            return root.levels.lvl_80[state];
        case percentage >= 70:
            return root.levels.lvl_70[state];
        case percentage >= 60:
            return root.levels.lvl_60[state];
        case percentage >= 50:
            return root.levels.lvl_50[state];
        case percentage >= 40:
            return root.levels.lvl_40[state];
        case percentage >= 30:
            return root.levels.lvl_30[state];
        case percentage >= 20:
            return root.levels.lvl_20[state];
        case percentage >= 10:
            return root.levels.lvl_10[state];
        default:
            return root.levels.alert;
        }
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
