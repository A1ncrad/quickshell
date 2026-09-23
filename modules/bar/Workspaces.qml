import QtQuick
import Quickshell.Hyprland
import qs.components
import qs.config
import qs.services

Pill {
    Repeater {
        model: Hyprland.workspaces
        // Special workspaces have negative ids and are shown by the dot below
        WorkspaceDot {
            active: modelData.active
            visible: modelData.id > 0

            TapHandler {
                margin: Theme.gap / 2 // dots are tiny, widen the hit area
                onTapped: Hypr.focusWorkspace(modelData.id)
            }
        }
    }

    WorkspaceDot {
        active: true // only visible while open
        visible: SpecialWorkspace.open

        TapHandler {
            margin: Theme.gap / 2
            onTapped: Hypr.toggleSpecial(SpecialWorkspace.name)
        }
    }
}
