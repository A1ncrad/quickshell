import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.services

// Time in the display type, then the date
ColumnLayout {
    id: root

    property bool alignRight: false

    readonly property int alignment: alignRight ? Qt.AlignRight : Qt.AlignLeft

    spacing: 0

    StyledText {
        id: digits

        Layout.alignment: root.alignment
        text: Time.time
        color: Theme.primary
        font.pixelSize: Theme.fontSizeDisplay
        font.variableAxes: ({ "wght": Theme.weightDisplay, "ROND": Theme.roundness, "opsz": 144 })

        // The font's line box is far taller than its digits: trim the empty ascent
        // above and the descent below, so the layout spaces the digits themselves
        Layout.topMargin: -(metrics.ascent + metrics.tightBoundingRect("0").top)
        Layout.bottomMargin: -metrics.descent

        FontMetrics {
            id: metrics
            font: digits.font
        }
    }

    StyledText {
        Layout.alignment: root.alignment
        Layout.topMargin: Theme.gapLarge
        // Optically line up with the digits' side bearing
        Layout.leftMargin: root.alignRight ? 0 : Theme.gap
        Layout.rightMargin: root.alignRight ? Theme.gap : 0
        text: Time.date
        font.pixelSize: Theme.fontSizeHeadline
        font.variableAxes: Theme.axes(Theme.weightRegular)
    }
}
