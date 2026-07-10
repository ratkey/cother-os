import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout {
  id: root
  spacing: 6

  property color colPrimary: "#ffffff"
  property color colWarning: "#e0af68"
  property color colError: "#ff0000"

  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 14

  property var battery: UPower.displayDevice
  readonly property bool isReady: battery && battery.ready
  property bool charging: isReady && battery.state === UPowerDeviceState.Charging
  readonly property int level: isReady ? Math.round(battery.percentage * 100) : 0

  readonly property string icon: {
    if (charging)
      return String.fromCodePoint(0xF0084);
    if (level >= 100)
      return String.fromCodePoint(0xF0079);
    if (level < 10)
      return String.fromCodePoint(0xF0083);

    return String.fromCodePoint(0xF007A + Math.floor(level / 10) - 1);
  }

  Text {
    text: root.icon
    color: root.charging ? root.colPrimary : root.level <= 15 ? root.colError : root.level <= 50 ? root.colWarning : root.colPrimary

    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }

  Text {
    text: root.level + "%"
    color: "#ffffff"
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }
}
