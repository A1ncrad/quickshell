import QtQuick
import Quickshell.Services.SystemTray
import qs.components
import qs.config
import qs.modules.common

// Windows 11-style tray overflow: a grid of tray icons; an item's menu replaces the grid in place
BarPopup {
    id: root

    property var menuItem: null // tray item whose menu is shown, null for the grid

    name: "tray"
    panel: card
    align: Qt.AlignRight

    onVisibleChanged: if (!visible) menuItem = null

    Card {
        id: card

        Grid {
            visible: root.menuItem === null
            columns: 4
            spacing: Theme.gapSmall

            Repeater {
                model: SystemTray.items

                TrayItem {
                    item: modelData
                    onActivated: Popups.close()
                    onMenuRequested: root.menuItem = modelData
                }
            }
        }

        Loader {
            active: root.menuItem !== null
            visible: active
            sourceComponent: TrayMenu {
                menu: root.menuItem?.menu ?? null
                onDone: Popups.close()
            }
        }
    }
}
