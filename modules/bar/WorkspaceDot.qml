import QtQuick
import qs.config

// Small filled dot; the active one grows into a ring
Rectangle {
    property bool active: false

    implicitWidth: active ? 11 : 6
    implicitHeight: implicitWidth
    radius: width / 2
    color: active ? "transparent" : Theme.surfaceVariant
    border.width: active ? 2 : 0
    border.color: Theme.primary

    Behavior on implicitWidth {
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
    }
}
