import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import qs.config

// Base for popups under the bar: shown while Popups.current === name, closes on click outside
// or after `timeout` ms without the cursor over it (0 disables).
// Subclasses set the horizontal anchor/margin and their size.
// A layer surface rather than a PopupWindow: Hyprland's focus grab ignores
// xdg popups, so a PopupWindow never receives pointer input.
PanelWindow {
    id: root

    required property var bar
    required property string name
    property int timeout: 3000

    anchors.top: true
    margins.top: Theme.barMargin + Theme.barHeight + 6
    color: "transparent"
    WlrLayershell.namespace: "quickshell:popup"
    exclusionMode: ExclusionMode.Ignore
    visible: Popups.current === name

    // The bar is included so clicking its trigger again toggles instead of reopening
    HyprlandFocusGrab {
        windows: [root, root.bar]
        active: root.visible
        onCleared: Popups.close()
    }

    HoverHandler { id: hover }

    // Stopping resets the countdown, so it starts over each time the cursor leaves
    Timer {
        interval: root.timeout
        running: root.visible && root.timeout > 0 && !hover.hovered
        onTriggered: Popups.close()
    }
}
