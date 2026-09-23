import QtQuick
import Quickshell.Widgets
import qs.config

// Tray icon. Left click activates (or opens the menu for menu-only items),
// right click opens the menu, middle click is the secondary action, wheel scrolls
Rectangle {
    id: root

    property var item // SystemTrayItem; not `required`, so the Repeater keeps providing modelData

    signal activated()
    signal menuRequested()

    implicitWidth: Theme.itemSize
    implicitHeight: Theme.itemSize
    radius: Theme.radius
    color: hover.hovered ? Theme.surfaceVariant : "transparent"

    IconImage {
        anchors.centerIn: parent
        source: root.item?.icon ?? ""
        implicitSize: Theme.iconSizeLarge
    }

    HoverHandler { id: hover }

    TapHandler {
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onTapped: (point, button) => {
            if (button === Qt.RightButton || (button === Qt.LeftButton && root.item.onlyMenu)) {
                if (root.item.hasMenu) root.menuRequested()
            } else if (button === Qt.MiddleButton) {
                root.item.secondaryActivate()
                root.activated()
            } else {
                root.item.activate()
                root.activated()
            }
        }
    }

    WheelHandler {
        onWheel: event => root.item.scroll(event.angleDelta.y, false)
    }
}
