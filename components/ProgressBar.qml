import QtQuick
import qs.config

// Horizontal bar; value is 0..1 (clamped)
Rectangle {
    id: root

    property real value: 0
    property alias fillColor: fill.color
    property bool animated: true

    implicitWidth: 100
    implicitHeight: 4
    radius: height / 2
    color: Theme.surfaceVariant

    Rectangle {
        id: fill
        width: root.width * Math.max(0, Math.min(1, root.value))
        height: root.height
        radius: root.radius
        color: Theme.primary

        Behavior on width {
            enabled: root.animated
            NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
        }
    }
}
