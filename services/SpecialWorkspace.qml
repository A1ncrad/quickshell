pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

// Open special workspace ("" when none). Quickshell doesn't expose it,
// so it is tracked from Hyprland's activespecial event.
Singleton {
    id: root

    property string name: ""
    readonly property bool open: name !== ""

    function set(workspace) { root.name = workspace.replace(/^special:/, "") }

    Connections {
        target: Hyprland
        // data: "special:magic,eDP-1" when opened, ",eDP-1" when closed
        function onRawEvent(event) {
            if (event.name === "activespecial") root.set(event.data.split(",")[0])
        }
    }

    // Events only report changes, so read the initial state once
    Process {
        running: true
        command: ["hyprctl", "monitors", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                const monitor = JSON.parse(text).find(m => m.focused)
                root.set(monitor?.specialWorkspace.name ?? "")
            }
        }
    }
}
