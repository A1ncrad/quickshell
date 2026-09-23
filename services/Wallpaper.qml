pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Current wallpaper, as reported by `awww query` (the wallpaper daemon; set by
// hypr/change-wallpaper/nextwall and prevwall). Queried once on load: the lock screen,
// the only user, starts a fresh process each time. Call refresh() to query again.
Singleton {
    id: root

    property string path: "" // the first output's image; "" for a solid colour or no daemon

    function refresh() { query.running = true }

    Process {
        id: query

        command: ["awww", "query"]
        running: true

        // One line per output: ": eDP-1: 1280x720, scale: 1.5, currently displaying: image: /path"
        stdout: StdioCollector {
            onStreamFinished: {
                const match = text.match(/currently displaying: image: (.+)$/m)
                root.path = match ? match[1].trim() : ""
            }
        }
    }
}
