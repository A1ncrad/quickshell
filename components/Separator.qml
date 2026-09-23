import QtQuick
import qs.config

// Horizontal divider with some vertical breathing room
Item {
    implicitWidth: Theme.borderWidth
    implicitHeight: Theme.separatorSpace

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: Theme.borderWidth
        color: Theme.surfaceVariant
    }
}
