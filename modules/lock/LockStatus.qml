import QtQuick.Layouts
import qs.components
import qs.config
import qs.modules.bar
import qs.services

// Network and battery in one glass pill, using the bar's icons. Glass rather than Pill:
// Hyprland can't blur behind a panel inside the lock surface
Glass {
    implicitWidth: row.implicitWidth + Theme.padding * 2
    implicitHeight: Theme.barHeight
    radius: height / 2

    RowLayout {
        id: row

        anchors.centerIn: parent
        spacing: Theme.iconGap

        NetworkStatus {}

        StyledText {
            text: Network.connected ? (Network.name || "Wired") : "Offline"
            font.pixelSize: Theme.fontSizeSmall
            Layout.maximumWidth: Theme.lockPromptWidth / 2
            Layout.rightMargin: Theme.gap
        }

        BatteryStatus {}

        StyledText {
            visible: Battery.available
            text: `${Battery.percentage}%`
            font.pixelSize: Theme.fontSizeSmall
        }
    }
}
