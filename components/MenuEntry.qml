import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.config

// Menu row: [indicator] [icon] text [›]. Generic: the owner maps its menu data onto it
Rectangle {
    id: root

    property alias text: label.text
    property string icon: ""      // image URL, "" for none
    property string indicator: "" // Material Symbols glyph (check box, radio, back…), "" for none
    property bool hasChildren: false

    signal clicked()

    implicitWidth: row.implicitWidth + Theme.gap * 2
    implicitHeight: Theme.itemSize
    radius: Theme.radius
    color: hover.hovered ? Theme.surfaceVariant : "transparent"
    opacity: enabled ? 1 : Theme.disabledOpacity

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.leftMargin: Theme.gap
        anchors.rightMargin: Theme.gap
        spacing: Theme.iconGap

        Icon {
            text: root.indicator
            visible: text !== ""
            color: Theme.text
        }

        IconImage {
            source: root.icon
            visible: root.icon !== ""
            implicitSize: Theme.iconSize
        }

        StyledText {
            id: label
            Layout.fillWidth: true
            font.pixelSize: Theme.fontSizeSmall
        }

        Icon {
            text: "chevron_right"
            visible: root.hasChildren
            color: Theme.outline
        }
    }

    HoverHandler { id: hover }
    TapHandler { onTapped: root.clicked() }
}
