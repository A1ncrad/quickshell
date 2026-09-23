import QtQuick
import qs.components
import qs.config
import qs.services

// ⏮ ⏯ ⏭ in a translucent pill (as in swaync)
Rectangle {
    implicitWidth: row.implicitWidth + Theme.gapSmall * 2
    implicitHeight: row.implicitHeight + Theme.gapTight * 2
    radius: height / 2
    color: Theme.controlFill

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Theme.gapTight

        IconButton { icon: "skip_previous"; onClicked: Media.previous() }
        IconButton { icon: Media.playing ? "pause" : "play_arrow"; onClicked: Media.togglePlaying() }
        IconButton { icon: "skip_next"; onClicked: Media.next() }
    }
}
