import QtQuick
import qs.config

// Small filled dot; the active one grows into a ring
Rectangle {
    property bool active: false

    implicitWidth: active ? Theme.dotSizeActive : Theme.dotSize
    implicitHeight: implicitWidth
    radius: width / 2
    color: active ? "transparent" : Theme.surfaceVariant
    border.width: active ? Theme.ringWidth : 0
    border.color: Theme.primary

    Behavior on implicitWidth {
        NumberAnimation { duration: Theme.durationShort; easing.type: Theme.easing }
    }
}
