import QtQuick
import qs.components
import qs.config
import qs.services

// ⏮ ⏯ ⏭ in a translucent pill (as in swaync)
Rectangle {
    implicitWidth: row.implicitWidth + 8
    implicitHeight: row.implicitHeight + 4
    radius: height / 2
    color: Qt.alpha(Theme.surfaceVariant, 0.6)

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 2

        IconButton { icon: "skip_previous"; onClicked: Media.previous() }
        IconButton { icon: Media.playing ? "pause" : "play_arrow"; onClicked: Media.togglePlaying() }
        IconButton { icon: "skip_next"; onClicked: Media.next() }
    }
}
