import QtQuick
import qs.components
import qs.config
import qs.modules.common

// Calendar card centered under the clock
BarPopup {
    id: root

    property real clockX // clock center, in bar coordinates

    name: "calendar"
    panel: card
    align: Qt.AlignHCenter
    centerX: Theme.barMargin + clockX

    onVisibleChanged: if (visible) calendar.reset()

    Card {
        id: card
        Calendar { id: calendar }
    }
}
