import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import qs.config

// Base for popups under the bar: shown while Popups.current === name, closes on click outside
// or after `timeout` ms without the cursor over it (0 disables).
// Subclasses set `panel` (their card) and `align`. The window is a full-width strip with
// Theme.shadowSpace of room around the panel for its shadow; only the panel takes input.
// A layer surface rather than a PopupWindow: Hyprland's focus grab ignores
// xdg popups, so a PopupWindow never receives pointer input.
PanelWindow {
    id: root

    required property var bar
    required property string name
    property int timeout: Theme.popupTimeout

    required property Item panel
    property int align: Qt.AlignLeft // AlignLeft, AlignRight or AlignHCenter
    property real centerX: 0         // AlignHCenter: the panel's centre, in screen coordinates

    anchors.top: true
    anchors.left: true
    anchors.right: true
    margins.top: Theme.barMargin + Theme.barHeight + Theme.popupGap - Theme.shadowSpace
    implicitHeight: panel.implicitHeight + Theme.shadowSpace * 2
    mask: Region { item: root.panel }
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

    Binding {
        target: root.panel
        property: "x"
        value: root.align === Qt.AlignRight ? root.width - root.panel.width - Theme.barMargin
             : root.align === Qt.AlignHCenter ? Math.max(Theme.barMargin, Math.min(root.width - root.panel.width - Theme.barMargin, root.centerX - root.panel.width / 2))
             : Theme.barMargin
    }

    Binding {
        target: root.panel
        property: "y"
        value: Theme.shadowSpace
    }

    HoverHandler { id: hover }

    // Stopping resets the countdown, so it starts over each time the cursor leaves
    Timer {
        interval: root.timeout
        running: root.visible && root.timeout > 0 && !hover.hovered
        onTriggered: Popups.close()
    }
}
