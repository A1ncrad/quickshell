import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.config

// List row: icon + title. `selected` highlights it; fallbackIcon shows when there is no image
Rectangle {
    id: root

    property alias title: label.text
    property string icon: ""               // image URL, "" for none
    property string fallbackIcon: "apps"   // Material Symbols glyph
    property bool selected: false

    signal clicked()

    implicitWidth: Theme.fieldWidth
    implicitHeight: Theme.listItemHeight
    radius: Theme.radius
    color: selected ? Theme.surfaceVariant : "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.padding
        anchors.rightMargin: Theme.padding
        spacing: Theme.gapLarge

        Item {
            implicitWidth: Theme.controlSize
            implicitHeight: Theme.controlSize

            IconImage {
                anchors.fill: parent
                source: root.icon
                visible: root.icon !== ""
            }

            Icon {
                anchors.centerIn: parent
                text: root.fallbackIcon
                visible: root.icon === ""
                color: Theme.outline
                font.pixelSize: Theme.iconSizeLarge
            }
        }

        StyledText {
            id: label
            Layout.fillWidth: true
        }
    }

    TapHandler { onTapped: root.clicked() }
}
