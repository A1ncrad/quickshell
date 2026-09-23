import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.modules.common
import qs.services

// rofi-style app launcher. Toggle with: qs ipc call launcher toggle
PanelWindow {
    id: root

    property bool open: false

    function show() {
        Popups.close()
        search.text = ""
        open = true
    }

    function hide() { open = false }

    function launch(app) {
        if (!app) return
        Apps.launch(app)
        hide()
    }

    // Top quarter rather than centered, so the window doesn't jump as results shrink
    anchors.top: true
    // Room around the card for its shadow; only the card takes input
    margins.top: screen.height / 4 - Theme.shadowSpace
    implicitWidth: card.implicitWidth + Theme.shadowSpace * 2
    implicitHeight: card.implicitHeight + Theme.shadowSpace * 2
    mask: Region { item: card }

    visible: open
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell:launcher"
    WlrLayershell.keyboardFocus: open ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    onVisibleChanged: if (visible) {
        search.focusInput()
        appear.restart()
    }

    // Not show()/hide(): "qs ipc call launcher show" collides with the `qs ipc show` subcommand
    IpcHandler {
        target: "launcher"
        function toggle(): void { root.open ? root.hide() : root.show() }
        function open(): void { root.show() }
        function close(): void { root.hide() }
    }

    HyprlandFocusGrab {
        windows: [root]
        active: root.visible
        onCleared: root.hide()
    }

    Card {
        id: card
        anchors.centerIn: parent

        ParallelAnimation {
            id: appear
            NumberAnimation { target: card; property: "opacity"; from: 0; to: 1; duration: Theme.durationShort; easing.type: Theme.easing }
            NumberAnimation { target: card; property: "scale"; from: Theme.enterScale; to: 1; duration: Theme.durationShort; easing.type: Theme.easing }
        }

        TextField {
            id: search
            Layout.fillWidth: true
            icon: "search"
            placeholder: "Search apps"

            Keys.onPressed: event => {
                // Vim-style: Ctrl+N / Ctrl+J down, Ctrl+P / Ctrl+K up
                if (event.modifiers & Qt.ControlModifier) {
                    switch (event.key) {
                    case Qt.Key_N:
                    case Qt.Key_J: list.move(1); break
                    case Qt.Key_P:
                    case Qt.Key_K: list.move(-1); break
                    default: return
                    }
                    event.accepted = true
                    return
                }

                switch (event.key) {
                case Qt.Key_Down:
                case Qt.Key_Tab: list.move(1); break
                case Qt.Key_Up:
                case Qt.Key_Backtab: list.move(-1); break
                case Qt.Key_PageDown: list.move(list.visibleRows); break
                case Qt.Key_PageUp: list.move(-list.visibleRows); break
                case Qt.Key_Return:
                case Qt.Key_Enter: root.launch(list.model[list.currentIndex]); break
                case Qt.Key_Escape: root.hide(); break
                default: return
                }
                event.accepted = true
            }
        }

        AppList {
            id: list
            Layout.fillWidth: true
            visible: count > 0
            model: Apps.search(search.text)
            onLaunched: app => root.launch(app)
        }

        StyledText {
            Layout.fillWidth: true
            Layout.margins: Theme.gap
            visible: list.count === 0
            text: `No apps match "${search.text.trim()}"`
            color: Theme.outline
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
