import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

RowLayout {
  id: root
  spacing: 7

  property color colPrimary: "#ffffff"
  property color colWarning: "#e0af68"
  property color colError: "#ff0000"

  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 14

  property var sink: Pipewire.defaultAudioSink

  readonly property bool ready: sink && sink.ready
  readonly property bool muted: ready && sink.audio.muted
  readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

  readonly property string icon: {
    if (!ready)
      return String.fromCodePoint(0xF0581);
    if (muted)
      return String.fromCodePoint(0xF0581);

    if (vol == 0)
      return String.fromCodePoint(0xF0581);
    if (vol < 34)
      return String.fromCodePoint(0xF057F);
    if (vol < 67)
      return String.fromCodePoint(0xF0580);

    return String.fromCodePoint(0xF057E);
  }

  Text {
    text: root.icon
    color: root.colPrimary
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }
  Text {
    text: root.vol + "%"
    color: root.colPrimary
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }

  PwObjectTracker {
    objects: [root.sink]
  }
}
