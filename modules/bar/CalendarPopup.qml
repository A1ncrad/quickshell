import qs.components
import qs.config
import qs.modules.common

// Calendar card centered under the clock
BarPopup {
    id: root

    property real centerX // clock center, in bar coordinates

    name: "calendar"
    anchors.left: true
    margins.left: Theme.barMargin + centerX - implicitWidth / 2
    implicitWidth: card.implicitWidth
    implicitHeight: card.implicitHeight

    onVisibleChanged: if (visible) calendar.reset()

    Card {
        id: card
        Calendar { id: calendar }
    }
}
