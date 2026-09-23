import QtQuick
import QtQuick.Layouts
import qs.config

// Icon with an optional label; the label is hidden while empty
RowLayout {
    id: root

    property alias icon: iconText.text
    property alias iconColor: iconText.color
    property alias label: labelText.text
    property real maxLabelWidth: Theme.labelMaxWidth

    spacing: Theme.iconGap

    Icon { id: iconText }

    StyledText {
        id: labelText
        visible: text !== ""
        Layout.maximumWidth: root.maxLabelWidth
    }
}
