import QtQuick
import qs.config

// Icon with a rounded background on hover
Rectangle {
    id: root

    property alias icon: glyph.text

    signal clicked()

    implicitWidth: 28
    implicitHeight: 28
    radius: Theme.radius
    color: hover.hovered ? Theme.surfaceVariant : "transparent"

    Icon {
        id: glyph
        anchors.centerIn: parent
        color: Theme.text
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: root.clicked() }
}
