import QtQuick
import qs.config

// Day cell. Background: selected > today / hover; days of other months are muted
Rectangle {
    id: root

    property int day
    property bool today: false
    property bool selected: false
    property bool outside: false

    signal clicked()

    implicitWidth: Theme.itemSize
    implicitHeight: Theme.itemSize
    radius: Theme.radius
    color: selected ? Theme.primary
         : today || hover.hovered ? Theme.surfaceVariant
         : "transparent"

    StyledText {
        anchors.centerIn: parent
        text: root.day
        font.pixelSize: Theme.fontSizeSmall
        color: root.selected ? Theme.textOnPrimary : root.outside ? Theme.outline : Theme.text
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: root.clicked() }
}
