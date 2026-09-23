import QtQuick
import qs.config

// Horizontal divider with some vertical breathing room
Item {
    implicitWidth: 1
    implicitHeight: 9

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 1
        color: Theme.surfaceVariant
    }
}
