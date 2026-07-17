import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "."

RowLayout {
    id: root
    spacing: 7

    property var sink: Pipewire.defaultAudioSink

    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property string icon: {
        if (!ready || muted)
            return String.fromCodePoint(0xF0581);

        if (vol == 0)
            return String.fromCodePoint(0xF0581);
        if (vol <= 10)
            return String.fromCodePoint(0xF057F);
        if (vol <= 30)
            return String.fromCodePoint(0xF0580);

        return String.fromCodePoint(0xF057E);
    }

    readonly property color kolor: {
        if (!ready || muted || vol == 0)
            return Theme.colStageEmpty;
        if (vol <= 10)
            return Theme.colStage4;
        if (vol <= 20)
            return Theme.colStage5;
        if (vol <= 40)
            return Theme.colStage6;
        if (vol <= 50)
            return Theme.colStage7;
        if (vol <= 80)
            return Theme.colStage8;
        return Theme.colStage8;
    }

    Text {
        text: root.icon
        color: root.kolor
        font {
            family: Theme.fontFamily
            pixelSize: Theme.iconSize
            bold: true
        }
    }

    PwObjectTracker {
        objects: [root.sink]
    }
}
